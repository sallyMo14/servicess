import 'package:flutter/material.dart';

class ContentCardWidget extends StatelessWidget {
  final String title;
  final String personName;
  final String location;
  final String salary;
  final String description;

  const ContentCardWidget({
    super.key,
    required this.title,
    required this.personName,
    required this.location,
    required this.salary,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey, width: .4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان والمفضلة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "  $title",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.favorite_border_outlined),
              ],
            ),
            const SizedBox(height: 5),
            // الاسم، الموقع، والراتب
            Row(
              children: [
                const SizedBox(width: 7),
                const Icon(Icons.person, size: 15),
                Text(
                  personName,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 7),
                const Icon(
                  Icons.location_on_outlined,
                  size: 15,
                  color: Color(0xFFFF4CB1),
                ),
                Text(
                  location,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 7),
                const Icon(
                  Icons.attach_money_sharp,
                  size: 15,
                  color: Color(0xFFFF4CB1),
                ),
                Text(
                  "$salary \$/Month",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 5),
            // الوصف
            Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 101, 101, 101),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
