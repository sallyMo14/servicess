import '../../data/models/job_application_model.dart';
import '../../data/repositories/job_repository.dart';

class ApplyToJobUseCase {
  final JobRepository repository;
  ApplyToJobUseCase(this.repository);

  Future<void> call(JobApplicationModel application) {
    return repository.applyToJob(application);
  }
}
