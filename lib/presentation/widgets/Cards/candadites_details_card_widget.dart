import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';


class CandidatesCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String tag;

  const CandidatesCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: const Row(
        children: [
          Icon(Icons.location_on, size: 16, color: AppColors.lightText),
          SizedBox(width: 4),
          Text('Lebanon', style: TextStyle(color: AppColors.lightText)),
          SizedBox(width: 4),
          Icon(Icons.star, color: AppColors.yellowAccent, size: 16),
          Icon(Icons.star, color: AppColors.yellowAccent, size: 16),
          Icon(Icons.star, color: AppColors.yellowAccent, size: 16),
          Icon(Icons.star_half, color: AppColors.yellowAccent, size: 16),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.indigo.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          tag,
          style: const TextStyle(fontSize: 10, color: Colors.indigo),
        ),
      ),
    );
  }
}
