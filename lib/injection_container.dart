import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'data/data_sources/invetation_remote_data_source.dart';
import 'data/data_sources/remote/user_info_remote_data_source.dart';
import 'data/repo_impl/Invetation_repo_impl.dart';
import 'data/repo_impl/user_profile_repo_impl.dart';
import 'data/repositories/invetation_repo.dart';
import 'data/repositories/user_profile_repo.dart';
import 'domain/usecases/accept_invetation_usecase.dart';
import 'domain/usecases/apply_to_job_usecase.dart';
import 'domain/usecases/get_provider_invetations_usecase.dart';
import 'domain/usecases/get_user_profile_info_usecase.dart';
import 'domain/usecases/reject_invetation_usecase.dart';
import 'presentation/bloc/invetation/invetation_bloc.dart';
import 'presentation/bloc/user_profile/user_profile_bloc.dart';
import 'data/data_sources/remote/job_remote_data_source.dart';
import 'data/repo_impl/job_repository_impl.dart';
import 'data/repositories/job_repository.dart';
import 'domain/usecases/post_job_usecase.dart';
import 'presentation/bloc/job/job_bloc.dart';


GetIt sl = GetIt.instance;
Future<void> initialaizedDependencies() async {
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerSingleton<UserInfoRemoteDataSource>(
    UserInfoRemoteDataSource(),
  );
  sl.registerSingleton<InvetationRemoteDataSource>(
    InvetationRemoteDataSource(dio: sl<Dio>()),
  );
  // ************************************************************
  sl.registerSingleton<UserProfileRepo>(
    UserProfileRepoImpl(
      userInfoRemoteDataSource: sl<UserInfoRemoteDataSource>(),
    ),
  );
  sl.registerSingleton<InvetationRepo>(
    InvetationRepoImpl(
      invetationRemoteDataSource: sl<InvetationRemoteDataSource>(),
    ),
  );
  // **********************************************************************

  sl.registerSingleton<GetUserProfileInfoUsecase>(
    GetUserProfileInfoUsecase(userInfoRepo: sl<UserProfileRepo>()),
  );
  sl.registerSingleton<GetProviderInvetationsUsecase>(
    GetProviderInvetationsUsecase(repo: sl<InvetationRepo>()),
  );
  sl.registerSingleton<AcceptInvetationUsecase>(
    AcceptInvetationUsecase(repo: sl<InvetationRepo>()),
  );
  sl.registerSingleton<RejectInvetationUsecase>(
    RejectInvetationUsecase(repo: sl<InvetationRepo>()),
  );
  // ******************************************************
  sl.registerFactory<UserProfileBloc>(
    () => UserProfileBloc(
      getUserInfoUsecase: sl<GetUserProfileInfoUsecase>(),
    ),
  );
  sl.registerFactory<InvetationBloc>(
    () => InvetationBloc(
      getProviderInvetationsUsecase:
          sl<GetProviderInvetationsUsecase>(),
      acceptInvetationUsecase: sl<AcceptInvetationUsecase>(),
      rejectInvetationUsecase: sl<RejectInvetationUsecase>(),
    ),
  );
  // ===================== JOB: Data source ======================
sl.registerLazySingleton<JobRemoteDataSource>(
  () => JobRemoteDataSource(
    baseUrl: 'http://10.0.2.2:8000/api', 
  ),
);

// ===================== JOB: Repository ======================
sl.registerLazySingleton<JobRepository>(
  () => JobRepositoryImpl(remote: sl<JobRemoteDataSource>()),
);

// ===================== JOB: UseCases ========================
sl.registerLazySingleton<PostJobUseCase>(
  () => PostJobUseCase(sl<JobRepository>()),
);
// sl.registerLazySingleton<PostJobUseCase>(() => PostJobUseCase(sl()));
sl.registerLazySingleton<ApplyToJobUseCase>(() => ApplyToJobUseCase(sl()));
// ===================== JOB: Bloc ============================

sl.registerFactory<JobBloc>(
  () => JobBloc(
    sl<JobRepository>(),
    sl<PostJobUseCase>(),
    sl<ApplyToJobUseCase>(),  
  ),
);
}
