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

  final double radius = 160.0; // Radius of the sphere

  // Rotation angles
  double angleX = 0;
  double angleY = 0;

  // Auto-rotation speeds
  final double velocityX = 0.003;
  final double velocityY = 0.003;

  @override
  void initState() {
    super.initState();
    _generateNodes();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 16))
      ..addListener(_updateRotation)
      ..repeat();
  }

  void _generateNodes() {
    // Generate 45 points using Fibonacci sphere algorithm for a denser planet
    int numNodes = 45;
    double phi = pi * (3.0 - sqrt(5.0)); // golden angle

    final List<String> fakeNames = ['温柔的鱼', '一只猫', '夏天的风', '无名之辈', '星空之下', '流浪者', 'Soul', '听雨', '微光'];

    for (int i = 0; i < numNodes; i++) {
      double y = 1 - (i / (numNodes - 1)) * 2; // y goes from 1 to -1
      double radiusAtY = sqrt(1 - y * y); // radius at y

      double theta = phi * i; // golden angle increment

      double x = cos(theta) * radiusAtY;
      double z = sin(theta) * radiusAtY;

      nodes.add(UserNode(
        id: i.toString(),
        name: fakeNames[i % fakeNames.length],
        avatarUrl: '', // Using icon instead
        isOnline: i % 4 == 0,
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
      angleX = details.delta.dy * 0.005;
      angleY = details.delta.dx * 0.005;
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
        height: 450,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Central "Me" text or graphic
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryTeal.withAlpha(50),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryTeal.withAlpha(30),
                      blurRadius: 40,
                      spreadRadius: 20,
                    )
                  ]
                ),
              ),

              // Draw the nodes
              ...sortedNodes.map((node) {
                // Projection parameters
                double scale = (radius + node.z) / (radius * 2); // 0 to 1 based on depth
                scale = 0.4 + (scale * 0.8); // 0.4 to 1.2

                // Add perspective effect to X and Y
                double perspective = 1000; // view distance
                double factor = perspective / (perspective - node.z);

                double left = node.x * factor;
                double top = node.y * factor;

                // Opacity fades slightly when in the back
                double opacity = 0.3 + (scale * 0.7);
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
    bool isSpecial = int.parse(node.id) % 7 == 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              width: isSpecial ? 54 : 46,
              height: isSpecial ? 54 : 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.primaries[int.parse(node.id) % Colors.primaries.length].withAlpha(200),
                    Colors.primaries[(int.parse(node.id) + 1) % Colors.primaries.length].withAlpha(200),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.white.withAlpha(150), width: 1.5),
                boxShadow: [
                  if (isSpecial)
                    BoxShadow(
                      color: Colors.white.withAlpha(100),
                      blurRadius: 12,
                      spreadRadius: 2,
                    )
                ]
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white.withAlpha(220),
                  size: isSpecial ? 32 : 26,
                ),
              ),
            ),
            if (node.isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
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
          isSpecial ? '99% 匹配' : node.name,
          style: TextStyle(
            color: isSpecial ? AppColors.primaryTeal : Colors.white70,
            fontSize: isSpecial ? 12 : 11,
            fontWeight: isSpecial ? FontWeight.bold : FontWeight.normal,
            shadows: const [
              Shadow(color: Colors.black54, blurRadius: 2, offset: Offset(1, 1))
            ]
          ),
        )
      ],
    );
  }
}
