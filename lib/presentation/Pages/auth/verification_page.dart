import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../allusers/provider_dashboard.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/buttons/custom_next_button.dart';
import '../../widgets/Inputs/otp_input.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (_) => FocusNode(),
  );
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  late String userEmail;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      userEmail = args;
    } else {
      userEmail = '';
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _submitCode() {
    final otpCode = _controllers.map((c) => c.text).join();

    if (otpCode.length == 6 && userEmail.isNotEmpty) {
      BlocProvider.of<AuthBloc>(
        context,
      ).add(VerifyCodePressed(email: userEmail, code: otpCode));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete code'),
        ),
      );
    }
    final email =
        ModalRoute.of(context)?.settings.arguments as String?;

    if (email != null) {
      BlocProvider.of<AuthBloc>(
        context,
      ).add(VerifyCodePressed(email: email, code: otpCode));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Missing email')));
    }
  }

  void _resendCode() {
    print('Resend code to $userEmail');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is VerificationSuccess) {
          final prefs = await SharedPreferences.getInstance();
          final userType = prefs.getString('user_type');
          if (userType == 'requester') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProviderDashboard(),
              ),
            );

            // Navigator.pushReplacementNamed(
            //   context,
            //   AppRoutes.requesterHome,
            // );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProviderDashboard(),
              ),
            );
            // Navigator.pushReplacementNamed(
            //   context,
            //   AppRoutes
            //       .providerHome, //! sally1 : i will make this go to general dashboard (later)
            // );
          }
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
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
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFF78DCB),
                child: Icon(
                  Icons.person,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Verify it’s you',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'We sent a code to ($userEmail). Enter it here to verify your identity',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.lightText),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => OtpInputField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(
                          context,
                        ).requestFocus(_focusNodes[index + 1]);
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(
                          context,
                        ).requestFocus(_focusNodes[index - 1]);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _resendCode,
                child: const Text(
                  'Resend Code',
                  style: TextStyle(color: AppColors.yellowAccent),
                ),
              ),
              const SizedBox(height: 24),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }

                  return CustomNextButton(
                    text: 'Confirm',
                    onPressed: _submitCode,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
