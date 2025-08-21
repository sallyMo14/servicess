import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/job_repository.dart';
import '../../../domain/usecases/apply_to_job_usecase.dart';
import 'job_event.dart';
import 'job_state.dart';
import '../../../domain/usecases/post_job_usecase.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository repository;
  final PostJobUseCase postJob;
  final ApplyToJobUseCase applyToJob;

  JobBloc(this.repository, this.postJob, this.applyToJob)
    : super(JobInitial()) {
    on<LoadJobs>((event, emit) async {
      emit(JobLoading());
      try {
        final jobs = await repository.getJobsByUserType(
          event.userType,
        );
        emit(JobLoaded(jobs));
      } catch (e) {
        emit(JobError('Failed uploading'));
      }
    });

    on<ApplyToJobPressed>(_onApplyToJob);

    on<PostJobPressed>((event, emit) async {
      emit(JobLoading());
      try {
        await postJob(event.jobData);
        emit(JobPostedSuccessfully());
      } catch (e) {
        emit(JobError("Fail posting a job ${e.toString()}"));
      }
    });

    on<SaveJobDraft>((event, emit) {
      emit(JobDraftSaved(event.jobData));
    });

    on<LoadMyJobs>((event, emit) async {
      emit(MyJobsLoading());
      try {
        final allJobs = await repository.getMyJobs(
          event.userId,
          event.userType,
        );
        final inProgress =
            allJobs
                .where((job) => job.status == 'in_progress')
                .toList();
        final done =
            allJobs.where((job) => job.status == 'done').toList();
        emit(MyJobsLoaded(inProgress: inProgress, done: done));
      } catch (e) {
        emit(JobError("Failing uploading jobs"));
      }
    });
  }

  Future<void> _onApplyToJob(
    ApplyToJobPressed event,
    Emitter<JobState> emit,
  ) async {
    emit(JobLoading());
    try {
      await applyToJob(event.application);
      emit(JobApplySuccess());
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }
}
