import 'package:flutter/cupertino.dart';

class BulletText extends StatelessWidget {
  final String text;
  const BulletText({super.key, required this.text, });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 16)),
        Expanded(child: Text(text)),
      ],
    );
  }
}
