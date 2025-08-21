import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sally_service4/presentation/bloc/invetation/invetation_bloc.dart';
import 'package:sally_service4/presentation/bloc/job/job_bloc.dart';
import 'data/repositories/auth_repository.dart';
import 'injection_container.dart';
import 'presentation/Pages/allusers/provider_dashboard.dart';
import 'presentation/Pages/provideruser/invetation_page.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/user_profile/user_profile_bloc.dart';
import 'presentation/routes/app_router.dart';
import 'presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialaizedDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();
  final AuthRepository authRepository = AuthRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<JobBloc>(create: (_) => sl<JobBloc>()),
        BlocProvider<UserProfileBloc>(
          create: (_) => sl<UserProfileBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create:
              (context) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider<InvetationBloc>(
          create: (_) => sl<InvetationBloc>(),
        ),
      ],
      //  child: MaterialApp(home: GeneralDashboard(),)
      child: const MaterialApp(
        title: 'Services App',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
// ProfilePage() for requester page