import 'package:flutter/material.dart';
import '../../widgets/Cards/candadite_card_widget.dart';

import '../../widgets/Inputs/search_bar.dart';

class RequesterJobCandidtatesPage extends StatelessWidget {
  RequesterJobCandidtatesPage({super.key});

  final List<Map<String, dynamic>> candidates = [
    {
      "name": "Mohammed Ahmed",
      "job": "Graphic Designer",
      "rating": 4.5,
      "location": "Gaza",
      "image": "assets/images/avatar1.png"
    },
    {
      "name": "Lina Khaled",
      "job": "UI/UX Designer",
      "rating": 4.0,
      "location": "Beirut",
      "image": "assets/images/avatar2.png"
    },
    {
      "name": "Yousef Ali",
      "job": "Mobile Developer",
      "rating": 3.5,
      "location": "Amman",
      "image": "assets/images/avatar3.png"
    },
    {
      "name": "Mariam Adel",
      "job": "Marketing Specialist",
      "rating": 5.0,
      "location": "Cairo",
      "image": "assets/images/avatar4.png"
    },
    {
      "name": "Ali Kassem",
      "job": "Backend Engineer",
      "rating": 4.2,
      "location": "Riyadh",
      "image": "assets/images/avatar5.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text("Job Title - Candidates")),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 20),
            // الحل هنا: نعطي ListView.builder ارتفاع واضح
            SizedBox(
              height: screenHeight * 0.8, // أو أي ارتفاع يناسبك
              child: ListView.builder(
                itemCount: candidates.length,
                itemBuilder: (context, index) {
                  final c = candidates[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CandidateCard(
                      name: c["name"],
                      job: c["job"],
                      rating: c["rating"],
                      location: c["location"],
                      imagePath: c["image"],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
