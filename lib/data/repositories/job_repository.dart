import 'package:sally_service4/domain/core/user_kinds.dart';
import '../models/job_application_model.dart';
import '../models/job_model.dart';
import 'package:sally_service4/domain/core/user_kinds.dart';

abstract class JobRepository {
  Future<List<JobModel>> getJobsByUserType(String userType);
  Future<void> applyToJob(JobApplicationModel application);
  Future<void> postJob(Map<String, dynamic> jobData);
  Future<List<JobModel>> getMyJobs(String userId, String userType);
  Future<List<JobModel>> getHomeJobs({
    required UserType userType,
    required EntityType entityType,
    required String userId,
  });
}
