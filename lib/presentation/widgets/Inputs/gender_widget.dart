import 'package:flutter/material.dart';
import 'buildSelecetableoption.dart';

enum Gender { male, female }

class GenderSelector extends StatelessWidget {
  final Gender? selectedGender;
  final Function(Gender) onChanged;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SelectableOptionWidget(
            icon: Icons.male,
            title: 'Male',
            selected: selectedGender == Gender.male,
            onTap: () => onChanged(Gender.male),
            width: double.infinity,
            height: 100,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SelectableOptionWidget(
            icon: Icons.female,
            title: 'Female',
            selected: selectedGender == Gender.female,
            onTap: () => onChanged(Gender.female),
            width: double.infinity,
            height: 100,
          ),
        ),
      ],
    );
  }
}