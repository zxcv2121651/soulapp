import 'package:flutter/material.dart';
import '../utils/colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                'Soul',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 24),
              const Text(
                '推荐',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primaryTeal,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                '广场',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: AppColors.textWhite),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none, color: AppColors.textWhite),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.tune, color: AppColors.textWhite),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
