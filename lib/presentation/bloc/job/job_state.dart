// lib/presentation/bloc/job/job_state.dart

import '../../../data/models/job_model.dart';

abstract class JobState {}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<JobModel> jobs;

  JobLoaded(this.jobs);
}

class JobError extends JobState {
  final String message;

  JobError(this.message);
}
class JobApplySuccess extends JobState {}
class JobPostedSuccessfully extends JobState {}
class JobDraftSaved extends JobState {
  final Map<String, dynamic> jobDraftData;
  JobDraftSaved(this.jobDraftData);
}
class MyJobsLoading extends JobState {}

class MyJobsLoaded extends JobState {
  final List<JobModel> inProgress;
  final List<JobModel> done;

  MyJobsLoaded({required this.inProgress, required this.done});
}
