import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../widgets/appear/custom_app_bar.dart';
import '../../widgets/Inputs/search_bar.dart';
import '../../widgets/Cards/service_card.dart';
import '../../widgets/appear/custom_bottom_nav.dart';

class ReqHomePage extends StatelessWidget {
  const ReqHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF4CB1),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
                child: const CustomAppBar(),
              ),
              const SizedBox(height: 36),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    ServiceCard(
                      onTap: () {
                        Navigator.pushNamed(context, '/jobdetails');
                      },
                      timeAgo: '10',
                      title: 'Logo Design',
                      userName: 'Sarah Kamel',
                      location: 'Jordan',
                      price: '\$250',
                      rating: 4,
                      description:
                          'Professional logo design for your business.',
                      avatarPath: 'assets/images/avatar.png',
                    ),
                    const SizedBox(height: 10),
                    ServiceCard(
                      onTap: () {
                        Navigator.pushNamed(context, '/jobdetails');
                      },
                      timeAgo: '20',
                      title: 'App Development',
                      userName: 'Yousef Tarek',
                      location: 'Egypt',
                      price: '\$1000',
                      rating: 5,
                      description:
                          'Custom mobile apps for Android/iOS.',
                      avatarPath: 'assets/images/avatar.png',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: SearchBarWidget(),
          ),
        ],
      ),
      // bottomNavigationBar:CustomBottomNav()

      // bottomNavigationBar:  CustomBottomNav(cureentIndex: 0, userType: 'requester',),
    );
  }
}
// AppRoutes.profile for provider homepage