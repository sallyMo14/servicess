import '../../data/repositories/job_repository.dart';

class PostJobUseCase {
  final JobRepository repository;
  PostJobUseCase(this.repository);

  Future<void> call(Map<String, dynamic> jobData) {
    return repository.postJob(jobData);
  }
}
