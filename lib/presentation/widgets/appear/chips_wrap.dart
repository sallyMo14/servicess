import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';

class ChipsWrap extends StatelessWidget {
  final List<String> skills;
  const ChipsWrap(this.skills, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skills
          .map((skill) => Chip(
                label: Text(skill),
                backgroundColor: AppColors.borderGrey,
              ))
          .toList(),
    );
  }
}
