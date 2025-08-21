import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../widgets/appear/custom_bottom_nav.dart';
import '../../widgets/Cards/service_card.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({super.key});

  @override
  State<MyJobsPage> createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  bool isInProgressSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   backgroundColor: AppColors.white,
      //   elevation: 0,
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text(
      //     'My Jobs',
      //     style: TextStyle(
      //       color: AppColors.darkText,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 18,
      //     ),
      //   ),
      //   actions: const [
      //     Padding(
      //       padding: EdgeInsets.only(right: 12),
      //       child: Icon(Icons.search, color: AppColors.darkText),
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTabButton('In Progress', isInProgressSelected, () {
                setState(() {
                  isInProgressSelected = true;
                });
              }),
              const SizedBox(width: 12),
              buildTabButton('Done', !isInProgressSelected, () {
                setState(() {
                  isInProgressSelected = false;
                });
              }),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: isInProgressSelected
                  ? _buildInProgressJobs(context)
                  : _buildDoneJobs(context),
            ),
          ),
        ],
      ),
        // bottomNavigationBar:CustomBottomNav()
    
      // bottomNavigationBar:  CustomBottomNav(cureentIndex: 2, userType: 'Provider',),
    );
  }

  Widget buildTabButton(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryPink : AppColors.greyBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    
  }

  List<Widget> _buildInProgressJobs(BuildContext context) {
    return [
      ServiceCard(
        timeAgo: 'After 15 Minutes',
        title: 'Facebook Social Media Design',
        userName: 'Madeha Ahmed',
        location: 'Lebanon',
        price: '1500 \$ /Month',
        rating: 3,
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been...',
        avatarPath: 'assets/images/avatar.png',
        onTap: () {
          Navigator.pushNamed(context, '/invitationdetails');
        },
      ),
      const SizedBox(height: 12),
      ServiceCard(
        timeAgo: 'After 15 Minutes',
        title: 'Facebook Social Media Design',
        userName: 'Madeha Ahmed',
        location: 'Lebanon',
        price: '1500 \$ /Month',
        rating: 3,
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been...',
        avatarPath: 'assets/images/avatar.png',
        onTap: () {},
      ),
      const SizedBox(height: 12),
      ServiceCard(
        timeAgo: 'After 15 Minutes',
        title: 'Facebook Social Media Design',
        userName: 'Madeha Ahmed',
        location: 'Lebanon',
        price: '1500 \$ /Month',
        rating: 3,
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been...',
        avatarPath: 'assets/images/avatar.png',
        onTap: () {},
      ),
    ];
  }

  List<Widget> _buildDoneJobs(BuildContext context) {
    return [
      ServiceCard(
        timeAgo: 'After 1 Hour',
        title: 'UI Design Project',
        userName: 'Sara Khaled',
        location: 'Palestine',
        price: '800 \$ /Month',
        rating: 5,
        description:
            'This is a completed job. Thank you for your amazing work!',
        avatarPath: 'assets/images/avatar.png',
        onTap: () {},
      ),
      const SizedBox(height: 12),
      ServiceCard(
        timeAgo: 'After 1 Hour',
        title: 'UI Design Project',
        userName: 'Sara Khaled',
        location: 'Palestine',
        price: '800 \$ /Month',
        rating: 5,
        description:
            'This is a completed job. Thank you for your amazing work!',
        avatarPath: 'assets/images/avatar.png',
        onTap: () {},
      ),
    ];
  }
}
