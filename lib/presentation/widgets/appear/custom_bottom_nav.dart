import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: AppColors.lightText,
      currentIndex: currentIndex,
      onTap: onTap,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),

        BottomNavigationBarItem(
          icon: Icon(Icons.business_center),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined),
          label: '',
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:servicess/core/utils/app_colors.dart';

// class CustomBottomNav extends StatelessWidget {
//   const CustomBottomNav({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       selectedItemColor: Colors.pinkAccent,
//       unselectedItemColor: AppColors.lightText,
//       currentIndex: 0,
//       onTap: (index) {},
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
//         BottomNavigationBarItem(icon: Icon(Icons.business_center), label: ''),
//         BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
//       ],
//     );
//   }
// }


// ! new code ( best way to use it is to make new page that have stable appbar: Dashboard ,  Scaffold body: wuse in it switch (with cases : 0 for home page , 1 for profile , 2 for invetations ,3 for settings) , and final is in the scaffold is this bottom navigation bar )
// ! this new page will enhance the performance , and it will make it easier to move from one page to other (note : if you want to do that , you have to remove all CustomNavigation bar in the selected pages , and make it as one custom bar in this new page)
// ! make navigating between them as pushNamedReplacment with arguemts , and dont put navigator.pop() in app bar as back arrow
/*
import 'package:flutter/material.dart';
import 'package:servicess/core/utils/app_colors.dart';
import 'package:servicess/presentation/Pages/Requister/requester_job_details_page.dart';
import 'package:servicess/presentation/Pages/Requister/requister_profile_page.dart';
import 'package:servicess/presentation/Pages/allusers/home_page.dart';
import 'package:servicess/presentation/Pages/provideruser/job_details_page.dart';
import 'package:servicess/presentation/routes/app_routes.dart';

class CustomBottomNav extends StatefulWidget {
  int cureentIndex;
  String userType;
  CustomBottomNav({super.key, required this.cureentIndex,required this.userType});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: AppColors.lightText,
      currentIndex: widget.cureentIndex,
      onTap: (index) {
        setState(() {
          widget.cureentIndex = index;
           String route = '';
    switch (index) {
      case 0:
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage(),));
        // route = AppRoutes.requesterHome;
        break;
      case 1:
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ProfilePage(),));

        // route = AppRoutes.profile;
        break;
      case 2:
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => JobDetailPage(),));

        // route = AppRoutes.requesterJobDetails;
        break;
      case 3:
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => RequesterJobDetailsPage(),));

        // route = AppRoutes.requesterPostedJobs;
        break;
    }
    //    Navigator.pushReplacementNamed(
    //   context,
    //   route,

    // );   
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        BottomNavigationBarItem(
          icon: Icon(Icons.business_center),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '',
        ),
      ],
    );
  }
}
 */