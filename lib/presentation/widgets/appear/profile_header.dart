import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String? name;
  final String? jobTitle;
  const ProfileHeader({super.key, this.name, this.jobTitle});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage: AssetImage('assets/images/profile.png'),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name??'default Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(jobTitle??'default jobTitle', style: TextStyle(color: Colors.grey)),
          ],
        )
      ],
    );
  }
}
