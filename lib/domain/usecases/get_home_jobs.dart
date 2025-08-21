import '../../data/repositories/job_repository.dart';
import '../core/user_kinds.dart';

import 'usecase.dart';
import '../../data/models/job_model.dart';

class GetHomeJobsParams {
  final UserType userType;
  final EntityType entityType;
  final String userId;
  GetHomeJobsParams({required this.userType, required this.entityType, required this.userId});
}

class GetHomeJobs implements UseCase<List<JobModel>, GetHomeJobsParams> {
  final JobRepository repo;
  GetHomeJobs(this.repo);

  @override
  Future<List<JobModel>> call(GetHomeJobsParams p) {
    return repo.getHomeJobs(
      userType: p.userType,
      entityType: p.entityType,
      userId: p.userId,
    );
  }
}
