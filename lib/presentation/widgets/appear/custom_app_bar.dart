import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.primaryPink,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('MY',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppColors.white)),
                  const SizedBox(width: 6),
                  Container(
                      width: 32, height: 5, color: AppColors.yellowAccent),
                ],
              ),
              const Text('SERVICES',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.white)),
            ],
          ),
          const Row(
            children: [
              Icon(Icons.notifications, color: AppColors.white),
              SizedBox(width: 16),
              Icon(Icons.mark_email_unread_outlined, color: AppColors.white),
            ],
          ),
        ],
      ),
    );
  }
}
