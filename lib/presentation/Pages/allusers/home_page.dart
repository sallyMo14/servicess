import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sally_service4/core/utils/app_colors.dart';

import '../../routes/app_routes.dart';

import '../../bloc/job/job_bloc.dart';
import '../../bloc/job/job_event.dart';
import '../../bloc/job/job_state.dart';
import 'package:sally_service4/injection_container.dart';

import '../../widgets/appear/custom_app_bar.dart';
import '../../widgets/Inputs/search_bar.dart';
import '../../widgets/Cards/service_card.dart';

import '../../../data/models/job_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _resolveUserType() {
    return 'provider';
  }

  @override
  Widget build(BuildContext context) {
    final userType = _resolveUserType();

    return BlocProvider<JobBloc>(
      create: (_) => sl<JobBloc>()..add(LoadJobs(userType)),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryPink,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(25),
                    ),
                  ),
                  child: const CustomAppBar(),
                ),
                const SizedBox(height: 36),

                Expanded(
                  child: BlocBuilder<JobBloc, JobState>(
                    builder: (context, state) {
                      if (state is JobLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is JobError) {
                        return Center(
                          child: Text('خطأ: ${state.message}'),
                        );
                      }
                      if (state is JobLoaded) {
                        final List<JobModel> jobs = state.jobs;
                        if (jobs.isEmpty) {
                          return const Center(
                            child: Text('Nothing to present'),
                          );
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          itemCount: jobs.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final job = jobs[index];

                            return ServiceCard(
                              onTap: () {
                                final safeId =
                                    int.tryParse(job.id) ?? 0;
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.jobDetails,
                                  arguments: {
                                    'jobId': safeId,
                                    'jobTitle': job.title,
                                  },
                                );
                              },

                              timeAgo: '15',
                              title: job.title,
                              userName: job.requesterId,
                              location: job.location,
                              price: '${job.salary}/Month',
                              rating: 3,
                              description: job.description,
                              avatarPath: 'assets/images/avatar.png',
                            );
                          },
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),

            const Positioned(
              top: 120,
              left: 20,
              right: 20,
              child: SearchBarWidget(),
            ),
          ],
        ),
        // bottomNavigationBar: CustomBottomNav()
        // bottomNavigationBar:  CustomBottomNav(cureentIndex: 0, userType: 'requester',),
      ),
    );
  }
}
