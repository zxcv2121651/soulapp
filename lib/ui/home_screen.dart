import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/home_header.dart';
import '../widgets/planet_widget.dart';
import '../widgets/bottom_controls.dart';
import '../widgets/starry_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: StarryBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              const HomeHeader(),

            // Planet (Expanded)
            const Expanded(
              child: Center(
                child: PlanetWidget(),
              ),
            ),

              // Bottom controls
              const BottomControls(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.bottomNavBackground,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.textWhite,
        unselectedItemColor: AppColors.textGrey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.public), label: '星球'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: '广场'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '聊天'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '自己'),
        ],
      ),
    );
  }
}
