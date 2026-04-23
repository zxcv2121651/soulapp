import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class StarryBackground extends StatelessWidget {
  final Widget child;

  const StarryBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF14172B),
            Color(0xFF262C4E),
            Color(0xFF1A1D36),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Render stars
          CustomPaint(
            size: Size.infinite,
            painter: _StarsPainter(),
          ),
          // Online count indicator
          Positioned(
            top: 130, // Pushed down to avoid header
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(50),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryTeal,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        '发现 8452367 个有趣的灵魂',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Filter indicator
          Positioned(
            top: 170, // Below online count
            right: 16,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(80),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.filter_list, color: Colors.white, size: 20),
                ),
                const SizedBox(height: 4),
                const Text(
                  '筛选',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                  ),
                )
              ],
            ),
          ),
          // Main content
          child,
        ],
      ),
    );
  }
}

class _StarsPainter extends CustomPainter {
  final Random random = Random(42); // Fixed seed for consistent stars

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (int i = 0; i < 150; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double radius = random.nextDouble() * 1.5;

      // Some stars are brighter
      int alpha = random.nextDouble() > 0.8
          ? 200 + random.nextInt(55)
          : 50 + random.nextInt(100);

      paint.color = Colors.white.withAlpha(alpha);

      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Add some larger glowing stars
    for (int i = 0; i < 5; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;

      paint.color = Colors.white.withAlpha(200);
      canvas.drawCircle(Offset(x, y), 2.5, paint);

      paint.color = Colors.white.withAlpha(50);
      canvas.drawCircle(Offset(x, y), 8.0, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
