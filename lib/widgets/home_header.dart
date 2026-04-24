import 'package:flutter/material.dart';
import '../utils/colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                '关注',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textLight, // Assuming textLight is white-ish
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(width: 20),
              const Text(
                '推荐',
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.textLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  const Text(
                    '同城',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textLight,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            ],
          ),

          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: AppColors.textLight, size: 28),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.notifications_none, color: AppColors.textLight, size: 28),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.tune, color: AppColors.textLight, size: 28),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
