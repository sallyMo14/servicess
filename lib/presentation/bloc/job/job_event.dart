

import '../../../data/models/job_application_model.dart';

abstract class JobEvent {}

class LoadJobs extends JobEvent {
  final String userType;

  LoadJobs(this.userType);

}
class ApplyToJobPressed extends JobEvent {
  final JobApplicationModel application;
  ApplyToJobPressed(this.application);
}
class PostJobPressed extends JobEvent {
  final Map<String, dynamic> jobData;
  PostJobPressed(this.jobData);
}
class SaveJobDraft extends JobEvent {
  final Map<String, dynamic> jobData;
  SaveJobDraft(this.jobData);
}
class LoadMyJobs extends JobEvent {
  final String userId;
  final String userType;

  LoadMyJobs({required this.userId, required this.userType});
}
