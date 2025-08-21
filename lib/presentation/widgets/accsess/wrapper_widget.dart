import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/user_utils.dart';

class ProviderOnly extends StatelessWidget {
  final Widget child;

  const ProviderOnly({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isProvider(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(); // أو Loader

        if (snapshot.data == true) {
          return child;
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("This page for provider user")),
            );
          });
          return const SizedBox();
        }
      },
    );
  }
}
