import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../routes/app_routes.dart';
import '../../widgets/Inputs/custom_text_field.dart';
import '../../widgets/buttons/custom_next_button.dart';
import '../../widgets/Inputs/custom_password.dart';

class CompanyRegisterContactPage extends StatefulWidget {
  const CompanyRegisterContactPage({super.key});

  @override
  State<CompanyRegisterContactPage> createState() =>
      _CompanyRegisterContactPageState();
}

class _CompanyRegisterContactPageState
    extends State<CompanyRegisterContactPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController companyEmailController =
      TextEditingController();
  final TextEditingController phoneNummberController =
      TextEditingController();
  final TextEditingController cityCountryController =
      TextEditingController();
  final TextEditingController detailedAddressController =
      TextEditingController();
  final TextEditingController posterCardController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late Map<String, dynamic> companyData;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      companyData = args;
    } else {
      companyData = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.darkText,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Company Sign Up',
          style: TextStyle(color: AppColors.darkText),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign up to your Contact',
                  style: TextStyle(color: AppColors.lightText),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: companyEmailController,
                  hint: 'Email',
                ),
                CustomTextField(
                  controller: phoneNummberController,
                  hint: 'Phone Number',
                ),
                CustomTextField(
                  controller: cityCountryController,
                  hint: 'City Country',
                ),
                CustomTextField(
                  controller: detailedAddressController,
                  hint: 'Detailed Address',
                ),
                CustomTextField(
                  controller: posterCardController,
                  hint: 'Poster Card',
                ),
                CustomPasswordField(
                  controller: passwordController,
                  hint: 'Password',
                ),
                CustomPasswordField(
                  hint: 'Confirm Password',
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 24),
                CustomNextButton(
                  onPressed: () {
                    Map<String, dynamic> allData = {
                      ...companyData,
                      'email': companyEmailController.text,
                      'phone': phoneNummberController.text,
                      'city': cityCountryController.text,
                      'postal_code': posterCardController.text,
                      "address": detailedAddressController.text,
                      'password': passwordController.text,
                      'password_confirmation':
                          confirmPasswordController.text,
                    };

                    print(
                      ' ******************************** page 2  $allData',
                    );

                    print(
                      "*******************************************************************************************************${jsonEncode(allData)}",
                    );
                    BlocProvider.of<AuthBloc>(
                      context,
                    ).add(RegisterPressed(allData));
                    Navigator.pushNamed(
                      context,
                      AppRoutes.verifyOtp,
                      arguments: companyEmailController.text,
                    );
                  },
                  text: 'Next',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    companyEmailController.dispose();
    phoneNummberController.dispose();
    cityCountryController.dispose();
    detailedAddressController.dispose();
    posterCardController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
