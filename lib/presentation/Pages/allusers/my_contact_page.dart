import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../../data/models/contact_model.dart';
import '../../widgets/Cards/contact_title_card.dart';

class MyContactPage extends StatelessWidget {
  MyContactPage({super.key});

  final List<ContactModel> contacts = [
    ContactModel(
        name: "Maria Sevrchenko",
        phoneMasked: "**** **** 2345",
        imagePath: "assets/images/contact1.jpg"),
    ContactModel(
        name: "Andrade Alexander Bade",
        phoneMasked: "**** **** 1158",
        imagePath: "assets/images/contact2.png"),
    ContactModel(
        name: "Michelle Princess",
        phoneMasked: "**** **** 5687",
        imagePath: "assets/images/contac1.jpg"),
    ContactModel(
        name: "Gladys Chou",
        phoneMasked: "**** **** 1200",
        imagePath: "assets/images/contact2.png"),
    ContactModel(
        name: "Mitchell Angela",
        phoneMasked: "**** **** 3620",
        imagePath: "assets/images/contact1.jpg"),
    ContactModel(
        name: "Xia Chung Ling",
        phoneMasked: "**** **** 3666",
        imagePath: "assets/images/contact2.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Contact",
          style: TextStyle(
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.greyBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.tune),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Recent contacts",
              style: TextStyle(
                color: AppColors.darkText,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: contacts.map((c) => ContactTile(contact: c)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
