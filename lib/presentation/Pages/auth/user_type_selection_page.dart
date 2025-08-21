import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../routes/app_routes.dart';

import '../../widgets/Inputs/buildSelecetableoption.dart';
import '../../widgets/buttons/custom_next_button.dart';

// import '../../data/models/user_type_model.dart';
// import '../pages/next_page.dart';
// import '../pages/register_page.dart'; // صفحة إنشاء حساب

class UserTypeSelectionPage extends StatefulWidget {
  const UserTypeSelectionPage({super.key});

  @override
  State<UserTypeSelectionPage> createState() =>
      _UserTypeSelectionPageState();
}

class _UserTypeSelectionPageState
    extends State<UserTypeSelectionPage> {
  String? userType; // 'provider' أو 'seeker'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // الشعار
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'MY',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 40,
                          height: 6,
                          color: AppColors.yellowAccent,
                        ),
                      ],
                    ),
                    const Text(
                      'SERVICES',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'Select your Type',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.lightText,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // خيارات النوع
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableOptionWidget(
                    title: 'Need a Service',
                    icon: Icons.help_outline,
                    selected: userType == 'seeker',
                    onTap: () {
                      setState(() {
                        userType = 'seeker';
                      });
                    },
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  SelectableOptionWidget(
                    title: 'Provide A Service',
                    icon: Icons.work_outline,
                    selected: userType == 'provider',
                    onTap: () {
                      setState(() {
                        userType = 'provider';
                      });
                    },
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // زر التالي
              CustomNextButton(
                onPressed: () {
                  if (userType != null) {
                    print('userType : $userType');
                    if (userType == 'provider') {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.providerType,
                        arguments: userType,
                      );
                    } else if (userType == 'seeker') {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.providerType,
                        arguments: userType,
                      );
                    }
                  }
                },
                text: 'Next',
              ),

              const SizedBox(height: 20),

              // رابط إنشاء حساب
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Have An Account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.signIn);
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
