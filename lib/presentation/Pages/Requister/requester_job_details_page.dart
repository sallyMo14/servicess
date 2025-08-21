import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../provideruser/job_details_page.dart';
import '../../widgets/Cards/candadites_details_card_widget.dart';

import '../../widgets/appear/chips_row.dart';
import '../../widgets/appear/chips_wrap.dart';
import '../../widgets/buttons/custom_next_button.dart';
import '../../widgets/appear/section_title_widget.dart';


class RequesterJobDetailsPage extends StatelessWidget {
  const RequesterJobDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: const Text(
          'Face Book Social Media ...',
          style:
              TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.darkText),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 16),
            const SectionTitle('Job Description'),
            const SizedBox(height: 8),
            const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
              style: TextStyle(color: AppColors.lightText),
            ),
            const SizedBox(height: 16),
            const SectionTitle('Job Requirements'),
            const SizedBox(height: 8),
            const BulletList(items: [
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              'Lorem Ipsum is simply dummy text',
            ]),
            const SizedBox(height: 16),
            const ChipsRow(['Part Time', 'On-Site', '1500\$ /M']),
            const SizedBox(height: 24),
            const SectionTitle('Required Skills'),
            const SizedBox(height: 12),
            const ChipsWrap(
                ['Graphic', 'Art', 'ASP.Net', 'PHP', 'UI/UX', 'Css', 'HTML 5']),
            const SizedBox(height: 24),
            const SectionTitle('Candidates'),
            const SizedBox(height: 12),
            const CandidatesCard(
              imagePath: 'assets/images/avatar.png',
              name: 'Mohamed Ahmed',
              tag: 'Graphic Designer',
            ),
            const CandidatesCard(
              imagePath: 'assets/images/avatar.png',
              name: 'Mohamed Ahmed',
              tag: 'Graphic Designer',
            ),
            const CandidatesCard(
              imagePath: 'assets/images/avatar.png',
              name: 'Mohamed Ahmed',
              tag: 'Graphic Designer',
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text('View All'),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_today, size: 16, color: AppColors.lightText),
                SizedBox(width: 8),
                Text(
                  'Application Deadline : 12 Feb 2025',
                  style: TextStyle(color: AppColors.lightText),
                ),
              ],
            ),
            const SizedBox(height: 32),
            CustomNextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/applyservice');
              },
              text: 'Apply',
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyBackground),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Madeha Ahmed',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: AppColors.lightText),
                  SizedBox(width: 4),
                  Text('Lebanon',
                      style: TextStyle(color: AppColors.lightText)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: List.generate(
                  4,
                  (index) => const Icon(Icons.star,
                      color: AppColors.yellowAccent, size: 16),
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.favorite_border),
        ],
      ),
    );
  }
}
