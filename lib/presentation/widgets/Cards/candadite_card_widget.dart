import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';

class CandidateCard extends StatelessWidget {
  final String name;
  final String job;
  final double rating;
  final String location;
  final String imagePath;

  const CandidateCard({
    super.key,
    required this.name,
    required this.job,
    required this.rating,
    required this.location,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        job,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color.fromARGB(255, 0, 85, 155),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Color(0xFFF890AA),
                    ),
                    const SizedBox(width: 5),
                    Text(location),
                    const SizedBox(width: 10),
                    ..._buildStars(rating),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStars(double rating) {
    List<Widget> stars = [];
    int full = rating.floor();
    bool half = (rating - full) >= 0.5;

    for (int i = 0; i < full; i++) {
      stars.add(const Icon(Icons.star, size: 14, color: AppColors.yellowAccent));
    }
    if (half) {
      stars.add(const Icon(Icons.star_half, size: 14, color: AppColors.yellowAccent));
    }
    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, size: 14, color: AppColors.yellowAccent));
    }
    return stars;
  }
}
