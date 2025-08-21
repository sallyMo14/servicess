import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/job_storage.dart';
import '../../bloc/job/job_bloc.dart';
import '../../bloc/job/job_event.dart';
import '../../bloc/job/job_state.dart';
import '../../widgets/Inputs/custom_text_box.dart';
import '../../widgets/Inputs/skills_input.dart';
import '../../widgets/buttons/custom_next_button.dart';

class CandidatesPage extends StatefulWidget {
  const CandidatesPage({super.key});

  @override
  State<CandidatesPage> createState() => _CandidatesPageState();
}

class _CandidatesPageState extends State<CandidatesPage> {
  final TextEditingController q1Controller = TextEditingController();
  final TextEditingController q2Controller = TextEditingController();
  final TextEditingController q3Controller = TextEditingController();

  @override
  void dispose() {
    q1Controller.dispose();
    q2Controller.dispose();
    q3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final storage = JobFormStorage();
    return BlocListener<JobBloc, JobState>(
      listener: (context, state) {
        if (state is JobLoading) {
          _showLoading(context);
          return;
        }
        _hideLoadingIfOpen(context);
        if (state is JobPostedSuccessfully) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Job posted successfully")),
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
          title: const Center(child: Text("Post a Job")),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Center(child: Text("Add A Question")),
              const SizedBox(height: 30),
              CustomTextBox(
                controller: q1Controller,
                hint: "Question 1",
              ),
              const SizedBox(height: 30),
              CustomTextBox(
                controller: q2Controller,
                hint: "Question 2",
              ),
              const SizedBox(height: 30),
              CustomTextBox(
                controller: q3Controller,
                hint: "Question 3",
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SkillsInput(),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: CustomNextButton(
                  onPressed: () {
                    storage.jobData.q1 = q1Controller.text;
                    storage.jobData.q2 = q2Controller.text;
                    storage.jobData.q3 = q3Controller.text;

                    final jobData = {
                      "title": storage.jobData.title,
                      "category": storage.jobData.category,
                      "job_type": storage.jobData.jobType,
                      "work_place": storage.jobData.workspace,
                      "experience_from":storage.jobData.ex_from,
                      "experience_to":storage.jobData.ex_to,
                      "country": storage.jobData.country,
                      "city": storage.jobData.city,
                      "salary_range": storage.jobData.salary,
                      "questions": [
                        storage.jobData.q1 ?? "no q1",
                        storage.jobData.q2 ?? "no q2",
                        storage.jobData.q3 ?? "no q3",
            ],
                      "skills": [
                        "skills",
                      ], // get the skills from the previous page (postjob page) and put it here as list
                      "deadline": "2025-08-16T22:36:37",
                    };
                    print(
                      "---------------------------------------------${jobData}---------------------------------------------",
                    );
                    context.read<JobBloc>().add(
                      PostJobPressed(jobData),
                    );
                    // Send jobData to repository
                  },
                  text: "Post the Job",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(child: CircularProgressIndicator()),
    useRootNavigator: true,
  );
}

void _hideLoadingIfOpen(BuildContext context) {
  final nav = Navigator.of(context, rootNavigator: true);
  if (nav.canPop()) nav.pop();
}
