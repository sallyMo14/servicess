import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../widgets/buttons/custom_next_button.dart';

class JobDetailPage extends StatelessWidget {
  final int jobId;
  final String jobTitle;

  const JobDetailPage({
    super.key,
    required this.jobId,
    required this.jobTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.darkText,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          jobTitle.isNotEmpty ? jobTitle : 'Job Details',
          style: const TextStyle(
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: AppColors.darkText,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 16),
            const Text(
              'Job Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              style: TextStyle(color: AppColors.lightText),
            ),
            const SizedBox(height: 16),
            const Text(
              'Job Requirements',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            const BulletList(
              items: [
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                'Lorem Ipsum is simply dummy text',
                'Lorem Ipsum is simply dummy text',
              ],
            ),
            const SizedBox(height: 16),
            _buildChipsRow(['Part Time', 'On-Site', '1500\$ /M']),
            const SizedBox(height: 24),
            const Text(
              'Required Skills',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildChipsWrap([
              'Graphic',
              'Art',
              'ASP.Net',
              'PHP',
              'UI/UX',
              'Css',
              'HTML 5',
            ]),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Application deadline : 12 Feb 2024',
                style: TextStyle(color: AppColors.lightText),
              ),
            ),
            const SizedBox(height: 32),
            CustomNextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.applyService,
                  arguments: {'jobId': jobId, 'jobTitle': jobTitle},
                );
              },
              text: 'Apply',
            ),
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
            radius: 24,
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
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppColors.lightText,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Lebanon',
                    style: TextStyle(color: AppColors.lightText),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: List.generate(
                  4,
                  (index) => const Icon(
                    Icons.star,
                    color: AppColors.yellowAccent,
                    size: 16,
                  ),
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

  Widget _buildChipsRow(List<String> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          items
              .map(
                (item) => Chip(
                  label: Text(item),
                  backgroundColor: AppColors.greyBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
              .toList(),
    );
  }

  Widget _buildChipsWrap(List<String> skills) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          skills
              .map(
                (skill) => Chip(
                  label: Text(skill),
                  backgroundColor: AppColors.borderGrey,
                ),
              )
              .toList(),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> items;
  const BulletList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          items
              .map(
                (text) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ", style: TextStyle(fontSize: 18)),
                    Expanded(
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: AppColors.lightText,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
    );
  }
}
