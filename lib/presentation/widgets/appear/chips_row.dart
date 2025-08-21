import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';

class ChipsRow extends StatelessWidget {
  final List<String> items;
  const ChipsRow(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items
          .map((item) => Chip(
                label: Text(item),
                backgroundColor: AppColors.greyBackground,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ))
          .toList(),
    );
  }
}
