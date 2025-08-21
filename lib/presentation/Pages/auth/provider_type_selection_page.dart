import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../widgets/Inputs/buildSelecetableoption.dart';
import '../../widgets/buttons/custom_next_button.dart';

class EntityTypeSelectionPage extends StatefulWidget {
  const EntityTypeSelectionPage({super.key});

  @override
  State<EntityTypeSelectionPage> createState() =>
      _EntityTypeSelectionPageState();
}

class _EntityTypeSelectionPageState extends State<EntityTypeSelectionPage> {
  String selectedServiceType = 'solo'; // Default value
  late String userType;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      userType = args;
    } else {
      userType = 'unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Select your Type',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.lightText,
                ),
              ),
              const SizedBox(height: 24),

              // خيار solo / company
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SelectableOptionWidget(
                    title: 'company',
                    icon: Icons.work_outline,
                    selected: selectedServiceType == 'company',
                    onTap: () {
                      setState(() {
                        selectedServiceType = 'company';
                      });
                    },
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  SelectableOptionWidget(
                    title: 'solo',
                    icon: Icons.person_outline,
                    selected: selectedServiceType == 'solo',
                    onTap: () {
                      setState(() {
                        selectedServiceType = 'solo';
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
                    //! i sent the user type (requster or company) , and the selcted service type (solo or company)
                  //! we can discard userType , but no problem to send both (it may help in future developments)
                 
                  if (selectedServiceType == 'company') {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.companyRegister,
                      arguments: {
                        'userType': userType,
                        'selectedServiceType': selectedServiceType,
                      },
                    );
                  } else {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.registerSolo,
                      arguments: {
                        'userType': userType,
                        'selectedServiceType': selectedServiceType,
                      },
                    );
                  }
                },
                text: 'Next',
              ),

              const SizedBox(height: 20),

              // تسجيل دخول
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
