// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../Requister/requister_profile_page.dart';
import 'provider_invetations_page.dart';
import 'provider_profile.dart';
import 'requester_home_page.dart';
import '../provideruser/invetation_details_page.dart';
import '../provideruser/invetation_page.dart';
import '../provideruser/my_jobs_page.dart';
import '../../widgets/Cards/service_card.dart';
import 'package:sidebarx/sidebarx.dart';

class SettingsPage extends StatelessWidget {
  final String userType;
  final String selectedServiceType;

  SettingsPage({
    Key? key,
    required this.userType,
    required this.selectedServiceType,
  }) : super(key: key);

  final SidebarXController _controller = SidebarXController(
    selectedIndex: 0,
    extended: true,
  );

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar:
          MediaQuery.of(context).size.width < 600
              ? AppBar(
                backgroundColor: AppColors.primaryPink,
                title: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return Text(
                      _getTitleByIndex(_controller.selectedIndex),
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _key.currentState?.openDrawer(),
                ),
              )
              : null,
      drawer: ExampleSidebarX(
        controller: _controller,
        userType: userType,
      ),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 600)
            ExampleSidebarX(
              controller: _controller,
              userType: userType,
            ),
          Expanded(
            child: _ScreensExample(
              controller: _controller,
              scaffoldKey: _key,
            ),
          ),
        ],
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  final String userType;
  final SidebarXController controller;

  const ExampleSidebarX({
    super.key,
    required this.controller,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primaryPink,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: AppColors.primaryPink.withOpacity(0.3),
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [AppColors.primaryPink, AppColors.primaryPink],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(
                255,
                226,
                143,
                143,
              ).withOpacity(0.3),
              blurRadius: 10,
            ),
          ],
        ),
      ),
      extendedTheme: const SidebarXTheme(
        textStyle: TextStyle(color: Colors.black),
        selectedTextStyle: TextStyle(color: Colors.white),
        width: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 228, 198, 198),
        ),
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/avatar.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.account_circle_outlined,
          label: 'Profile',
        ),
        SidebarXItem(
          icon: Icons.call_received_rounded,
          label:
              userType == 'requester'
                  ? 'Sent Invitations'
                  : 'My Invitations',
        ),
        SidebarXItem(
          icon: Icons.work,
          label: userType == 'requester' ? 'Posted Jobs' : 'My Jops',
        ),
        SidebarXItem(icon: Icons.list, label: 'Save List'),
        SidebarXItem(
          icon: Icons.contact_emergency_sharp,
          label: 'My contracts',
        ),
        SidebarXItem(icon: Icons.star, label: 'verify my account'),
        SidebarXItem(
          icon: Icons.policy_outlined,
          label: 'Our Policy',
        ),
        SidebarXItem(icon: Icons.payment, label: 'Payment'),
        SidebarXItem(
          icon: Icons.all_inbox_outlined,
          label: 'About Us',
        ),
        SidebarXItem(
          icon: Icons.support_agent_outlined,
          label: 'Support',
        ),
      ],
    );
  }
}

class _ScreensExample extends StatelessWidget {
  final SidebarXController controller;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const _ScreensExample({
    required this.controller,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        if (isSmallScreen &&
            scaffoldKey.currentState?.isDrawerOpen == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).maybePop();
          });
        }

        switch (controller.selectedIndex) {
          case 0:
            return RequesterProfilePage();
          case 1:
            return ProviderInvetationsPage();
          case 2:
            return MyJobsPage();
          case 3:
            return Center(child: Text("Saved List Screen"));
          case 4:
            return Center(child: Text("Contracts"));
          case 5:
            return Center(child: Text("Verify Accounts"));
          case 6:
            return Center(child: Text("Policies"));
          case 7:
            return Center(child: Text("Payment"));
          case 8:
            return Center(child: Text("About Us"));
          case 9:
            return Center(child: Text("Support"));
          default:
            return Center(child: Text("Not Found"));
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Profile';
    case 1:
      return 'Invitations';
    case 2:
      return 'Jobs';
    case 3:
      return 'Saved Lists';
    case 4:
      return 'My Contracts';
    case 5:
      return 'Verify Account';
    case 6:
      return 'Policies';
    case 7:
      return 'Payment';
    case 8:
      return 'About Us';
    case 9:
      return 'Support';
    default:
      return 'Page';
  }
}
