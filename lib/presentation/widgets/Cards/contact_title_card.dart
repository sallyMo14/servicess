import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../../data/models/contact_model.dart';


class ContactTile extends StatelessWidget {
  final ContactModel contact;

  const ContactTile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundImage: AssetImage(contact.imagePath),
        radius: 24,
      ),
      title: Text(
        contact.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: AppColors.darkText,
        ),
      ),
      subtitle: Text(
        contact.phoneMasked,
        style: const TextStyle(color: AppColors.lightText, fontSize: 12),
      ),
      onTap: () {
        
      },
    );
  }
}
