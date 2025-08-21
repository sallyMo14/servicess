import 'package:flutter/material.dart';
import 'package:sally_service4/core/helper/auth_helper.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    await _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString('user_type');
    bool isLoggedIn = await AuthHelper.isLoggedIn();
isLoggedIn=false; // comment this and make isLoggedIn a final after done making the logout

    if (!mounted) return;

    if (isLoggedIn && userType != null) {
      if (userType == 'provider') {
        Navigator.pushReplacementNamed(context, AppRoutes.providerHome); // make it provider dashboard
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.requesterHome);// make it requester dashboard
      }
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.signIn);//! change here 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: AppColors.primaryPink,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 145,
                height: 80,
                child: Stack(
                  children: [
                    Positioned(
                      top: 25,
                      right: 8,
                      child: Container(
                        width: 40,
                        height: 6,
                        color: AppColors.yellowAccent,
                      ),
                    ),
                    const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'MY',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            'SERVICES',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                color: AppColors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds:3), () {
//       Navigator.pushReplacementNamed(context, '/signin');
//     });
//       _checkLoginStatus();
//   }
//   void _checkLoginStatus() async {
//    final prefs = await SharedPreferences.getInstance();
//   final userType = prefs.getString('user_type');
//   final isLoggedIn = await AuthHelper.isLoggedIn();
// if (isLoggedIn && userType != null) {
//  if (userType == 'Provider') {
//       Navigator.pushReplacementNamed(context, AppRoutes.providerHome);
//  }
//      else {
//       Navigator.pushReplacementNamed(context, AppRoutes.requesterHome);
//     }}
//   else {
//     Navigator.pushReplacementNamed(context, AppRoutes.signIn);
//   }

   
//   } 
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // خلفية الصورة
//           Image.asset(
//             'assets/images/splash.png',
//             fit: BoxFit.cover,
//           ),

//           // تغطية وردية شفافة
//           Container(
//             color:
//              AppColors.primaryPink,
//           ),

//           // الشعار والتحميل
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // مربع الشعار
//               SizedBox(
//                   width: 145,
//                   height: 80,
//                   child: Stack(
//                     children: [
//                       // الشريط البرتقالي
//                       Positioned(
//                         top: 25,
//                         right: 8,
//                         child: Container(
//                           width: 40,
//                           height: 6,
//                           color: AppColors.yellowAccent,
//                         ),
//                       ),
//                       const Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'MY',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.white,
//                               ),
//                             ),
//                             Text(
//                               'SERVICES',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   )),

//               const SizedBox(height: 30),
//               const CircularProgressIndicator(
//                 color: AppColors.white,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
