import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../../data/models/job_application_model.dart';
import '../../bloc/job/job_bloc.dart';
import '../../bloc/job/job_event.dart';
import '../../bloc/job/job_state.dart';
import '../../widgets/Inputs/custom_text_box.dart';
import '../../widgets/accsess/wrapper_widget.dart';
import '../../widgets/buttons/custom_next_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyServicePage extends StatefulWidget {
  final int jobId;
  final String jobTitle;

  const ApplyServicePage({
    super.key,
    required this.jobId,
    required this.jobTitle,
  });

  @override
  State<ApplyServicePage> createState() => _ApplyServicePageState();
}

class _ApplyServicePageState extends State<ApplyServicePage> {
  final TextEditingController q1 = TextEditingController();
  final TextEditingController q2 = TextEditingController();
  final TextEditingController q3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkUserType();
  }

  Future<void> _checkUserType() async {
    final prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString('user_type');
    if (userType != 'provider' && mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('هذه الصفحة مخصصة لمزودي الخدمات فقط'),
        ),
      );
    }
  }

  void _showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder:
          (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _hideLoadingIfOpen(BuildContext context) {
    final nav = Navigator.of(context, rootNavigator: true);
    if (nav.canPop()) nav.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderOnly(
      child: BlocListener<JobBloc, JobState>(
        listener: (context, state) {
          if (state is JobLoading) {
            _showLoading(context);
            return;
          } else {
            _hideLoadingIfOpen(context);
          }

          if (state is JobApplySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Apply Success')),
            );
            Navigator.pop(context);
          } else if (state is JobError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.darkText,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            elevation: 0,
            backgroundColor: AppColors.white,
            centerTitle: true,
            title: Text(
              widget.jobTitle.isNotEmpty
                  ? widget.jobTitle
                  : 'Apply Service',
              style: const TextStyle(
                color: AppColors.darkText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Answer This Questions',
                    style: TextStyle(color: AppColors.lightText),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextBox(controller: q1, hint: 'Question One'),
                CustomTextBox(controller: q2, hint: 'Question Two'),
                CustomTextBox(controller: q3, hint: 'Question Three'),
                const Spacer(),
                CustomNextButton(
                  onPressed: () async {
                    if (q1.text.isEmpty ||
                        q2.text.isEmpty ||
                        q3.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('يرجى تعبئة كل الأسئلة'),
                        ),
                      );
                      return;
                    }

                    final prefs =
                        await SharedPreferences.getInstance();
                    final providerId =
                        prefs.getString('auth_token') ?? '';
                    print(providerId);
                    if (providerId.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('سجّلي الدخول أولاً'),
                        ),
                      );
                      return;
                    }

                    final application = JobApplicationModel(
                      jobId: widget.jobId,
                      providerId: providerId,
                      answer1: q1.text,
                      answer2: q2.text,
                      answer3: q3.text,
                    );

                    context.read<JobBloc>().add(
                      ApplyToJobPressed(application),
                    );
                  },
                  text: 'Send',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
