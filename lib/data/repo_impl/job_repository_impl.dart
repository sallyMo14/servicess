import '../data_sources/remote/job_remote_data_source.dart';
import '../models/job_application_model.dart';
import '../models/job_model.dart';
import '../repositories/job_repository.dart';
import 'package:sally_service4/domain/core/user_kinds.dart';

class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remote;
  JobRepositoryImpl({required this.remote});

  @override
  Future<void> applyToJob(JobApplicationModel application) =>
      remote.applyToJob(application);

  @override
  Future<void> postJob(Map<String, dynamic> jobData) =>
      remote.postJob(jobData);

  @override
  Future<List<JobModel>> getJobsByUserType(String userType) =>
      remote.getJobsByUserType(userType);

  @override
  Future<List<JobModel>> getMyJobs(String userId, String userType) =>
      remote.getMyJobs(userId, userType);

   @override
  Future<List<JobModel>> getHomeJobs({
    required UserType userType,
    required EntityType entityType,
    required String userId,
  }) {
   
    return remote.getHomeJobs(userId: userId, userType: userType.name, entityType: entityType.name
     
    );
  }
}
