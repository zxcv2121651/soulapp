import 'package:flutter/material.dart';
import '../utils/colors.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '点击寻找有趣的灵魂',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 12),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircularAction(
                title: '语音匹配',
                color1: const Color(0xFFF165A6),
                color2: const Color(0xFFE94E77),
                icon: Icons.mic,
              ),
              _buildCircularAction(
                title: '灵魂匹配',
                color1: const Color(0xFF5D54F6),
                color2: const Color(0xFF8278F9),
                icon: Icons.favorite,
                isLarge: true,
              ),
              _buildCircularAction(
                title: '恋爱铃',
                color1: const Color(0xFF904CE0),
                color2: const Color(0xFFB57BF3),
                icon: Icons.favorite_border,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularAction({
    required String title,
    required Color color1,
    required Color color2,
    required IconData icon,
    bool isLarge = false,
  }) {
    double size = isLarge ? 80 : 64;
    double iconSize = isLarge ? 36 : 28;

    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: color1.withAlpha(100),
                blurRadius: 15,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Center(
            child: Icon(icon, color: Colors.white, size: iconSize),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
