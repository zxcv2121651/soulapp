import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(const SoulApp());
}

class SoulApp extends StatelessWidget {
  const SoulApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soul App Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        primaryColor: AppColors.primaryTeal,
        useMaterial3: true,
        fontFamily: 'Roboto', // Fallback
      ),
      home: const HomeScreen(),
    );
  }
}
