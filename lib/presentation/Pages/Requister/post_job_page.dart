import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/job_storage.dart';
import '../../bloc/job/job_bloc.dart';
import '../../routes/app_routes.dart';
import '../../widgets/Inputs/buildSelecetableoption.dart';
import '../../widgets/Inputs/custom_text_field.dart';
import '../../widgets/buttons/custom_next_button.dart';

class PostJopPage extends StatefulWidget {
  const PostJopPage({super.key});

  @override
  State<PostJopPage> createState() => _PostJopPageState();
}

class _PostJopPageState extends State<PostJopPage> {
  final TextEditingController jobTitleController =
      TextEditingController();
  final TextEditingController jobCategoryController =
      TextEditingController();
  final TextEditingController countryController =
      TextEditingController();
  final TextEditingController cityController =
      TextEditingController();
  final TextEditingController salaryRangeController =
      TextEditingController();

  List<String> jobTypeOptions = [
    'Full Time',
    'Part Time',
    'Freelancer',
  ];
  List<String> workSpaceOptions = ['On Site', 'Remote', 'Hybrid'];
  int selectedJobTypeIndex = 0;
  int selectedWorkSpaceIndex = 0;

  int exFrom = 0;
  int exTo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Post a Job"))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: jobTitleController,
              hint: "Job Title",
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: jobCategoryController,
              hint: "Job Category",
            ),
            const SizedBox(height: 10),
            ...buildSelectableOptionGroup(
              title: "Job Type",
              options: jobTypeOptions,
              selectedIndex: selectedJobTypeIndex,
              onSelect:
                  (index) =>
                      setState(() => selectedJobTypeIndex = index),
            ),
            const SizedBox(height: 10),
            ...buildSelectableOptionGroup(
              title: "Work Space",
              options: workSpaceOptions,
              selectedIndex: selectedWorkSpaceIndex,
              onSelect:
                  (index) =>
                      setState(() => selectedWorkSpaceIndex = index),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: countryController,
              hint: "Country",
            ),
            const SizedBox(height: 10),
            CustomTextField(controller: cityController, hint: "City"),
            const SizedBox(height: 10),
            const Text(
              "Years of Experience",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            _buildCounterRangePicker(),
            const SizedBox(height: 10),
            CustomTextField(
              controller: salaryRangeController,
              hint: "Salary Range",
            ),
            const SizedBox(height: 20),
            CustomNextButton(
              onPressed: () {
                final storage = JobFormStorage();

                storage.jobData.title = jobTitleController.text;
                storage.jobData.category = jobCategoryController.text;
                storage.jobData.country = countryController.text;
                storage.jobData.city = cityController.text;
                storage.jobData.salary = salaryRangeController.text;
                storage.jobData.jobType =
                    jobTypeOptions[selectedJobTypeIndex];
                storage.jobData.workspace =
                    workSpaceOptions[selectedWorkSpaceIndex];
                storage.jobData.ex_from = exFrom.toString();
                storage.jobData.ex_to = exTo.toString();

                Navigator.pushNamed(
                  context,
                  AppRoutes.candidates,
                  arguments: context.read<JobBloc>(),
                );
              },
              text: "Next",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterRangePicker() {
    Widget buildCounter({
      required String label,
      required int value,
      required VoidCallback onIncrement,
      required VoidCallback onDecrement,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _circleIcon(Icons.add, onIncrement),
            const SizedBox(width: 12),
            Text(
              "$label\n$value",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(width: 12),
            _circleIcon(Icons.remove, onDecrement),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildCounter(
          label: "From",
          value: exFrom,
          onIncrement: () => setState(() => exFrom++),
          onDecrement:
              () => setState(() {
                if (exFrom > 0) exFrom--;
              }),
        ),
        buildCounter(
          label: "To",
          value: exTo,
          onIncrement: () => setState(() => exTo++),
          onDecrement:
              () => setState(() {
                if (exTo > 0) exTo--;
              }),
        ),
      ],
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
        child: Icon(icon, size: 16, color: Colors.grey[700]),
      ),
    );
  }

  List<Widget> buildSelectableOptionGroup({
    required String title,
    required List<String> options,
    required int selectedIndex,
    required Function(int) onSelect,
  }) {
    return [
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      const SizedBox(height: 10),
      Row(
        children: List.generate(options.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SelectableOptionWidget(
              title: options[index],
              selected: selectedIndex == index,
              onTap: () => onSelect(index),
              width: index == 2 ? 120 : 100,
              height: 55,
            ),
          );
        }),
      ),
    ];
  }
}
