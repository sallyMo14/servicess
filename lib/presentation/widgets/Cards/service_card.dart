import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';

class ServiceCard extends StatelessWidget {
  final String timeAgo;
  final String title;
  final String userName;
  final String location;
  final String price;
  final double rating;
  final String description;
  final String avatarPath;
  final VoidCallback? onTap;

  const ServiceCard({
    super.key,
    required this.timeAgo,
    required this.title,
    required this.userName,
    required this.location,
    required this.price,
    required this.rating,
    required this.description,
    required this.avatarPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: AppColors.borderGrey, blurRadius: 10),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              timeAgo,
              style: const TextStyle(
                color: AppColors.lightText,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.favorite_border,
                  color: AppColors.lightText,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage: AssetImage(avatarPath),
                ),
                const SizedBox(width: 4),
                Text(userName),
                const SizedBox(width: 8),
                const Icon(
                  Icons.location_on,
                  size: 14,
                  color: AppColors.lightText,
                ),
                Text(location),
                const SizedBox(width: 8),
                const Icon(Icons.attach_money, size: 14),
                Text(price),
                const SizedBox(width: 8),
              ],
            ),
            SizedBox(height: 10),
            Row(children: [..._buildStars(rating)]),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(color: Colors.black87),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalf = rating - fullStars >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(
        const Icon(
          Icons.star,
          size: 14,
          color: AppColors.yellowAccent,
        ),
      );
    }
    if (hasHalf) {
      stars.add(
        const Icon(
          Icons.star_half,
          size: 14,
          color: AppColors.yellowAccent,
        ),
      );
    }
    while (stars.length < 5) {
      stars.add(
        const Icon(
          Icons.star_border,
          size: 14,
          color: AppColors.yellowAccent,
        ),
      );
    }
    return stars;
  }
}
