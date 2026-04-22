import 'package:flutter/material.dart';
import '../utils/colors.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            title: '灵魂匹配',
            subtitle: 'Soul Match',
            color: AppColors.buttonBlue,
            icon: Icons.favorite,
          ),
          _buildActionButton(
            title: '语音匹配',
            subtitle: 'Voice Match',
            color: AppColors.buttonPink,
            icon: Icons.mic,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required String subtitle,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 140,
      height: 60,
      decoration: BoxDecoration(
        color: color.withAlpha(230), // 0.9 * 255
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(102), // 0.4 * 255
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withAlpha(204), // 0.8 * 255
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
