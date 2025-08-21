import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadBox extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final PlatformFile? file;

  const UploadBox({
    super.key,
    required this.text,
    required this.onTap,
    this.file,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          file != null ? file!.name : text,
          style: TextStyle(color: file != null ? Colors.black : Colors.grey),
        ),
      ),
    );
  }
}
