import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../routes/app_routes.dart';
import '../../widgets/Inputs/custom_password.dart';
import '../../widgets/Inputs/custom_text_field.dart';
import '../../widgets/buttons/custom_next_button.dart';
import '../../widgets/Inputs/gender_widget.dart';

class RegisterSoloPage extends StatefulWidget {
  const RegisterSoloPage({super.key});

  @override
  State<RegisterSoloPage> createState() => _RegisterSoloPageState();
}

class _RegisterSoloPageState extends State<RegisterSoloPage> {
  final _formKey = GlobalKey<FormState>();
  Gender? selectedGender;

  final TextEditingController fullNameController =
      TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController =
      TextEditingController();
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController phoneNumberController =
      TextEditingController();
  final TextEditingController cityController =
      TextEditingController();
  final TextEditingController zipCodeController =
      TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  late String user_role;
  late String account_type;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    print("args in a map $args");
    if (args != null && args is Map) {
      user_role = args['userType'];
      account_type = args['selectedServiceType'];
    } else {
      user_role = 'unknown';
      account_type = 'unknown';
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    ageController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    cityController.dispose();
    zipCodeController.dispose();
    super.dispose();
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
          'Solo Sign Up',
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
                  'Sign up to your Solo',
                  style: TextStyle(color: AppColors.lightText),
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: fullNameController,
                  hint: 'Full Name',
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: ageController,
                  hint: 'Age',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: GenderSelector(
                        selectedGender: selectedGender,
                        onChanged: (gender) {
                          setState(() {
                            selectedGender = gender;
                            genderController.text =
                                selectedGender
                                    .toString()
                                    .split('.')
                                    .last;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: emailController,
                  hint: 'Email',
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: phoneNumberController,
                  hint: 'Phone Number',
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: cityController,
                  hint: 'City/Country',
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: zipCodeController,
                  hint: 'Zip Code',
                ),
                const SizedBox(height: 24),
                if (user_role == 'seeker') ...[
                  CustomPasswordField(
                    controller: passwordController,
                    hint: 'Password',
                  ),
                  const SizedBox(height: 5),

                  CustomPasswordField(
                    controller: confirmPasswordController,
                    hint: 'Confirm Password',
                  ),
                ],
                const SizedBox(height: 24),

                CustomNextButton(
                  onPressed: () {
                    Map<String, dynamic> soloData;
                    if (user_role == 'seeker') {
                      soloData = {
                        'full_name': fullNameController.text,
                        'age': ageController.text,
                        'gender': genderController.text,
                        'email': emailController.text,
                        'phone': phoneNumberController.text,
                        'city': cityController.text,
                        'zip_code': zipCodeController.text,
                        'user_role':
                            user_role, // temp , origin user_role
                        'account_type': account_type, //account_type,
                        'password': passwordController.text,
                        'password_confirmation':
                            confirmPasswordController.text,
                      };
                    } else {
                      soloData = {
                        "full_name": fullNameController.text,
                        "age": ageController.text,
                        "gender": genderController.text,
                        "email": emailController.text,
                        "phone": phoneNumberController.text,
                        "city": cityController.text,
                        "zip_code": zipCodeController.text,
                        "user_role": user_role,
                        "account_type": account_type,
                      };
                    }

                    print(
                      "*********************************** account_type:${account_type}",
                    );
                    print(
                      "*********************************a** user_role:${user_role}",
                    );
                    print(
                      'SOLO DATA IN REGISTER SOLO PAGE (1): $soloData',
                    );
                    if (user_role == 'seeker') {
                      print(
                        '*********************************************************************************',
                      );

                      BlocProvider.of<AuthBloc>(
                        context,
                      ).add(RegisterPressed(soloData));
                      Navigator.pushNamed(
                        context,
                        AppRoutes.verifyOtp,
                        arguments: emailController.text,
                      );
                    } else {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.registerSoloPersonal,
                        arguments: soloData,
                      );
                    }
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
}
