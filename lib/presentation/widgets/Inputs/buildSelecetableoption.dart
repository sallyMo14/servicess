import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';

class SelectableOptionWidget extends StatelessWidget {
  final String title;
  final IconData? icon; 
  final bool selected;
  final VoidCallback onTap;
  final double width;
  final double height;

  const SelectableOptionWidget({
    super.key,
    required this.title,
    this.icon, 
    required this.selected,
    required this.onTap,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF636CD8) : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderGrey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 36, color: selected ? Colors.white : Colors.black),
              const SizedBox(height: 8),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: selected ? AppColors.white : AppColors.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
