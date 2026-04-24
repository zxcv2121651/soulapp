import 'package:flutter/material.dart';
import '../widgets/starry_background.dart';
import '../widgets/home_header.dart';
import '../widgets/planet_widget.dart';
import '../widgets/bottom_controls.dart';
import '../utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          // Background stars
          const StarryBackground(),

          SafeArea(
            child: Column(
              children: [
                // Top Header (Tabs and Icons)
                const HomeHeader(),

                // 3D Planet Area
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // The interactive 3D Planet
                      const PlanetWidget(),

                      // Match Button in the center bottom
                      Positioned(
                        bottom: 0,
                        child: _buildMatchButton(),
                      ),
                    ],
                  ),
                ),

                // Bottom Control Buttons (Camera, Voice, etc.)
                const BottomControls(),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Custom Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNavigationBar(),
          )
        ],
      ),
    );
  }

  Widget _buildMatchButton() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryTeal.withAlpha(20),
        border: Border.all(color: AppColors.primaryTeal.withAlpha(50), width: 1),
      ),
      child: Center(
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF6ED8CD), Color(0xFF45A29A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryTeal.withAlpha(100),
                blurRadius: 15,
                spreadRadius: 2,
              )
            ]
          ),
          child: const Center(
            child: Text(
              '灵魂匹配',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.backgroundDark,
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.public, '星球', true),
          _buildNavItem(Icons.explore_outlined, '发现', false),
          const SizedBox(width: 40), // Space for FAB
          _buildNavItem(Icons.chat_bubble_outline, '聊天', false),
          _buildNavItem(Icons.person_outline, '自己', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? AppColors.primaryTeal : Colors.grey[600],
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primaryTeal : Colors.grey[600],
            fontSize: 10,
          ),
        )
      ],
    );
  }
}
