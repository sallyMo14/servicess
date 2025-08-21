

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sally_service4/injection_container.dart';
import '../../data/repositories/auth_repository.dart';
import '../Pages/Requister/candidates_page.dart';
import '../Pages/Requister/post_job_page.dart';
import '../Pages/Requister/requester_job_candidates.dart';
import '../Pages/Requister/requester_job_details_page.dart';
import '../Pages/Requister/requester_posted_jobs_page.dart';
import '../Pages/allusers/home_page.dart';
import '../Pages/allusers/my_contact_page.dart';
import '../Pages/allusers/provider_profile.dart';
import '../Pages/allusers/requester_home_page.dart';
import '../Pages/allusers/splash_page.dart';
import '../Pages/auth/provider_type_selection_page.dart';
import '../Pages/auth/register_company_contact_page.dart';
import '../Pages/auth/register_company_page.dart';
import '../Pages/auth/register_solo_page.dart';
import '../Pages/auth/register_solo_personal_page.dart';
import '../Pages/auth/signIn_page.dart';
import '../Pages/auth/user_type_selection_page.dart';
import '../Pages/auth/verification_page.dart';
import '../Pages/provideruser/apply_service.dart';
import '../Pages/provideruser/invetation_details_page.dart';
import '../Pages/provideruser/invetation_page.dart';
import '../Pages/provideruser/job_details_page.dart';
import '../Pages/provideruser/my_jobs_page.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/job/job_bloc.dart';


import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(settings: settings,builder: (_) => const SplashPage());

// 
  //   case AppRoutes.requesterProfile:
  // return MaterialPageRoute(settings: settings,
  //   builder: (_) => BlocProvider(
  //     create: (_) => AuthBloc(authRepository: AuthRepository()),
  //     child: const SignInPage(),
  //   ),
  // );
    case AppRoutes.signIn:
  return MaterialPageRoute(settings: settings,
    builder: (_) => BlocProvider(
      create: (_) => AuthBloc(authRepository: AuthRepository()),
      child: const SignInPage(),
    ),
  );


      case AppRoutes.userType:
        return MaterialPageRoute(settings: settings,builder: (_) => const UserTypeSelectionPage());

      case AppRoutes.providerType:
        return MaterialPageRoute(settings: settings,builder: (_) => const EntityTypeSelectionPage());

      case AppRoutes.companyRegister:
      return MaterialPageRoute(settings: settings,
         builder: (_) => BlocProvider(
          create: (_) => AuthBloc(authRepository: AuthRepository()),
          child: const CompanyRegisterPage(), 
        ),
           );
       

      case AppRoutes.companyContact:
      return MaterialPageRoute(settings: settings,
         builder: (_) => BlocProvider(
          create: (_) => AuthBloc(authRepository: AuthRepository()),
          child: const CompanyRegisterContactPage(), 
        ),
           );
        

      case AppRoutes.providerHome:
        return MaterialPageRoute(settings: settings,builder: (_) => const HomePage());
         case AppRoutes.requesterHome:
        return MaterialPageRoute(settings: settings,builder: (_) => const ReqHomePage());
case AppRoutes.jobDetails: {

  final Map<String, dynamic> args =
      (settings.arguments ?? const <String, dynamic>{}) as Map<String, dynamic>;

  final int jobId = (args['jobId'] as int?) ?? 0;
  final String jobTitle = (args['jobTitle'] as String?) ?? 'Job';

  return MaterialPageRoute(
    settings: settings,
    builder: (_) => JobDetailPage(
      jobId: jobId,
      jobTitle: jobTitle,
    ),
  );
}


      case AppRoutes.applyService:
  final args = settings.arguments as Map<String, dynamic>? ?? {};
  final int jobId = args['jobId'] ?? 0;
  final String jobTitle = args['jobTitle'] ?? 'Job';
        return MaterialPageRoute(
  settings: settings,
    builder: (_) => ApplyServicePage(jobId: jobId, jobTitle: jobTitle),
        );

      case AppRoutes.profile:
        return MaterialPageRoute(settings: settings,builder: (_) => const ProviderProfilePage()); //ProfilePage()

      case AppRoutes.invitations:
        return MaterialPageRoute(settings: settings,builder: (_) => const InvetationPage());

      case AppRoutes.invitationDetails:
        return MaterialPageRoute(settings: settings,builder: (_) => const InvitationDetailsPage(invitationId: '',));

      case AppRoutes.myJob:
        return MaterialPageRoute(settings: settings,builder: (_) => const MyJobsPage());

      case AppRoutes.myContact:
        return MaterialPageRoute(settings: settings,builder: (_) => MyContactPage());

      case AppRoutes.registerSolo:
        return MaterialPageRoute(settings: settings,
         builder: (_) => BlocProvider(
          create: (_) => AuthBloc(authRepository: AuthRepository()),
          child: const RegisterSoloPage(), 
        ),
           );


      case AppRoutes.registerSoloPersonal:
      return MaterialPageRoute(settings: settings,
         builder: (_) => BlocProvider(
          create: (_) => AuthBloc(authRepository: AuthRepository()),
          child: const RegisterSoloPagePersonal(), 
        ),
           );
       

 
    case AppRoutes.verifyOtp:
      return MaterialPageRoute(settings: settings,
       builder: (_) => BlocProvider(
       create: (_) => AuthBloc(authRepository: AuthRepository()),
       child: const VerifyOtpPage(),
    ),
  );

       

      case AppRoutes.candidates:
       final jobBloc = settings.arguments as JobBloc;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<JobBloc>.value(
            value: jobBloc, 
            child: const CandidatesPage(),
          ),
        );

      case AppRoutes.postJob:
        return MaterialPageRoute(   builder: (_) => BlocProvider<JobBloc>(
            create: (_) => sl<JobBloc>(), // JobBloc جديد من DI
            child: const PostJopPage(),
          ),);

      case AppRoutes.requesterJobCandidates:
        return MaterialPageRoute(settings: settings,builder: (_) => RequesterJobCandidtatesPage());

      case AppRoutes.requesterJobDetails:
        return MaterialPageRoute(settings: settings,builder: (_) => const RequesterJobDetailsPage());

      case AppRoutes.requesterPostedJobs:
        return MaterialPageRoute(settings: settings,builder: (_) => const requester_posted_jobs_page());

      default:
        return MaterialPageRoute(settings: settings,
          builder: (_) => const Scaffold(
            body: Center(child: Text("Page not found")),
          ),
        );
    }
  }
}
