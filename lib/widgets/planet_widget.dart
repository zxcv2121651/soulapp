import 'dart:math';
import 'package:flutter/material.dart';
import '../models/user_node.dart';
import '../utils/colors.dart';

class PlanetWidget extends StatefulWidget {
  const PlanetWidget({super.key});

  @override
  State<PlanetWidget> createState() => _PlanetWidgetState();
}

class _PlanetWidgetState extends State<PlanetWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<UserNode> nodes = [];

  final double radius = 150.0; // Radius of the sphere

  // Rotation angles
  double angleX = 0;
  double angleY = 0;

  // Auto-rotation speeds
  final double velocityX = 0.002;
  final double velocityY = 0.002;

  @override
  void initState() {
    super.initState();
    _generateNodes();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..addListener(_updateRotation)
      ..repeat();
  }

  void _generateNodes() {
    // Generate 30 points using Fibonacci sphere algorithm
    int numNodes = 30;
    double phi = pi * (3.0 - sqrt(5.0)); // golden angle

    for (int i = 0; i < numNodes; i++) {
      double y = 1 - (i / (numNodes - 1)) * 2; // y goes from 1 to -1
      double radiusAtY = sqrt(1 - y * y); // radius at y

      double theta = phi * i; // golden angle increment

      double x = cos(theta) * radiusAtY;
      double z = sin(theta) * radiusAtY;

      nodes.add(UserNode(
        id: i.toString(),
        name: 'User $i',
        avatarUrl: String.fromCharCode(65 + (i % 26)), // A, B, C...
        isOnline: i % 3 == 0, // Random online status
        x: x * radius,
        y: y * radius,
        z: z * radius,
      ));
    }
  }

  void _updateRotation() {
    setState(() {
      angleX = velocityX;
      angleY = velocityY;
      _applyRotation();
    });
  }

  void _applyRotation() {
    double sinX = sin(angleX);
    double cosX = cos(angleX);
    double sinY = sin(angleY);
    double cosY = cos(angleY);

    for (var node in nodes) {
      // 1. Rotate around X axis
      double y1 = node.y * cosX - node.z * sinX;
      double z1 = node.z * cosX + node.y * sinX;

      // 2. Rotate around Y axis
      double x2 = node.x * cosY + z1 * sinY;
      double z2 = z1 * cosY - node.x * sinY;

      // Update node's current coordinates
      node.x = x2;
      node.y = y1;
      node.z = z2;
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      // Adjust rotation speed based on drag
      angleX = details.delta.dy * 0.01;
      angleY = details.delta.dx * 0.01;
      _applyRotation();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sort nodes by Z index to render nodes in back first (painters algorithm)
    List<UserNode> sortedNodes = List.from(nodes);
    sortedNodes.sort((a, b) => a.z.compareTo(b.z));

    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      child: Container(
        color: Colors.transparent, // Capture gestures
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Draw the nodes
              ...sortedNodes.map((node) {
                // Projection parameters
                double scale = (radius + node.z) / (radius * 2); // 0 to 1 based on depth
                // Add minimum scale to keep them visible
                scale = 0.5 + (scale * 0.5);

                // Add perspective effect to X and Y
                double perspective = 800; // view distance
                double factor = perspective / (perspective - node.z);

                double left = node.x * factor;
                double top = node.y * factor;

                // Opacity fades slightly when in the back
                double opacity = 0.4 + (scale * 0.6);
                if (opacity > 1) opacity = 1;
                if (opacity < 0) opacity = 0;

                return Transform.translate(
                  offset: Offset(left, top),
                  child: Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: opacity,
                      child: _buildNodeWidget(node),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNodeWidget(UserNode node) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.primaries[int.parse(node.id) % Colors.primaries.length].withAlpha(204), // 0.8 * 255
                border: Border.all(color: Colors.white24, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withAlpha(51), // 0.2 * 255
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ]
              ),
              child: Center(
                child: Text(
                  node.avatarUrl,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (node.isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.backgroundDark, width: 2),
                  ),
                ),
              )
          ],
        ),
        const SizedBox(height: 4),
        Text(
          node.name,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
