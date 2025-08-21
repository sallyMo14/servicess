import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';

class CustomNextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomNextButton({
    super.key,
    required this.onPressed,
   required this.text, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16,color:AppColors.white)),
      ),
    );
  }
}
