import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';

class BulletList extends StatelessWidget {
  final List<String> items;
  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((text) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(fontSize: 18)),
                  Expanded(
                      child: Text(text,
                          style: const TextStyle(color: AppColors.lightText))),
                ],
              ))
          .toList(),
    );
  }
}
