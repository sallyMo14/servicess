import 'package:flutter/material.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import 'package:sally_service4/presentation/bloc/invetation/invetation_bloc.dart';
import '../../routes/app_routes.dart';
import '../../widgets/Cards/service_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import 'package:sally_service4/presentation/bloc/invetation/invetation_bloc.dart';
import '../../routes/app_routes.dart';
import '../../widgets/Cards/service_card.dart';

class InvetationPage extends StatefulWidget {
  const InvetationPage({super.key});

  @override
  State<InvetationPage> createState() => _InvetationPageState();
}

class _InvetationPageState extends State<InvetationPage> {
  @override
  void initState() {
    super.initState();
    // Fetch invitations with BLoC
    context.read<InvetationBloc>().add(
      GetInvetationsEvent(userId: "123"), // replace with real userId
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.darkText,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: const Text(
          'Invitations',
          style: TextStyle(
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: implement search logic
            },
            icon: const Icon(Icons.search),
            color: AppColors.darkText,
          ),
        ],
      ),
      body: BlocConsumer<InvetationBloc, InvetationState>(
        listener: (context, state) {
          if (state is InvetationExceptionState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is InvetationLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GotInvetationsState) {
            if (state.invetations.isEmpty) {
              return const Center(
                child: Text("No Invitations Available"),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: state.invetations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final inv = state.invetations[index] ?? {};

                return ServiceCard(
                  timeAgo: inv['timeAgo']?.toString() ?? 'N/A',
                  title: inv['title']?.toString() ?? 'Unknown',
                  userName: inv['userName']?.toString() ?? 'Unknown',
                  location: inv['location']?.toString() ?? 'Unknown',
                  price: inv['price']?.toString() ?? 'N/A',
                  rating: inv['rating'] ?? 0,
                  description: inv['description']?.toString() ?? '',
                  avatarPath: 'assets/images/avatar.png',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.invitationDetails,
                      arguments: inv,
                    );
                  },
                );
              },
            );
          }

          return const Center(child: Text("Loading invitations..."));
        },
      ),
    );
  }
}

// !NEWER OLDER CODE
// class InvetationPage extends StatefulWidget {
//   const InvetationPage({super.key});

//   @override
//   State<InvetationPage> createState() => _InvetationPageState();
// }

// class _InvetationPageState extends State<InvetationPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Automatically trigger fetch when page is opened
//     context.read<InvetationBloc>().add(
//           GetInvetationsEvent(userId: "123"), // replace with actual userId if needed
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText),
//           onPressed: () => Navigator.pop(context),
//         ),
//         elevation: 0,
//         backgroundColor: AppColors.white,
//         centerTitle: true,
//         title: const Text(
//           'Face Book Social Media ...',
//           style: TextStyle(
//             color: AppColors.darkText,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: BlocConsumer<InvetationBloc, InvetationState>(
//         listener: (context, state) {
//           if (state is InvetationExceptionState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is InvetationLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is GotInvetationsState) {
//             if (state.invetations.isEmpty) {
//               return const Center(
//                 child: Text("No Invitations Available"),
//               );
//             }

//             return ListView.builder(
//               itemCount: state.invetations.length,
//               itemBuilder: (context, index) {
//                 final inv = state.invetations[index] ?? {};

//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ServiceCard(
//                     timeAgo: inv['timeAgo']?.toString() ?? 'N/A',
//                     title: inv['title']?.toString() ?? 'Unknown',
//                     userName: inv['userName']?.toString() ?? 'Unknown',
//                     location: inv['location']?.toString() ?? 'Unknown',
//                     price: inv['price']?.toString() ?? 'N/A',
//                     rating: inv['rating'] ?? 0,
//                     description: inv['description']?.toString() ?? '',
//                     avatarPath: 'assets/images/avatar.png',
//                     onTap: () {
//                       Navigator.pushNamed(
//                         context,
//                         AppRoutes.invitationDetails,
//                         arguments: inv,
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }

//           return const Center(
//             child: Text("Loading invitations..."),
//           );
//         },
//       ),
//     );
//   }
// }
// ! OLD CODE
// class InvetationPage extends StatelessWidget {
//   const InvetationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText),
//           onPressed: () => Navigator.pop(context),
//         ),
//         elevation: 0,
//         backgroundColor: AppColors.white,
//         centerTitle: true,
//         title: const Text(
//           'Face Book Social Media ...',
//           style:
//               TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.search),
//             color: AppColors.darkText,
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               children: [
//                 Column(
//                   children: [
//                     ServiceCard(
//                       timeAgo: '15',
//                       title: 'FaceBook Social Media Design',
//                       userName: 'Madeha Ahmed',
//                       location: 'Lebanon ',
//                       price: '1500/Month',
//                       rating: 3,
//                       description:
//                           'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
//                       avatarPath: 'assets/images/avatar.png',
//                       onTap: () {
//                         Navigator.pushNamed(context, AppRoutes.invitationDetails);
//                       },
//                     ),
//                     const SizedBox(height: 10),
//                     ServiceCard(
//                       timeAgo: '10',
//                       title: 'Instagram Campaign Design',
//                       userName: 'Ali Khaled',
//                       location: 'Palestine',
//                       price: '1200/Month',
//                       rating: 4,
//                       description:
//                           'Campaign design for Instagram. Reach and audience strategies.',
//                       avatarPath: 'assets/images/avatar.png',
//                       onTap: () {
//                         Navigator.pushNamed(context, AppRoutes.invitationDetails);
//                       },
//                     ),
//                     const SizedBox(height: 10),
//                     ServiceCard(
//                       timeAgo: '30',
//                       title: 'LinkedIn Branding Kit',
//                       userName: 'Sara N.',
//                       location: 'Egypt',
//                       price: '1700/Month',
//                       rating: 5,
//                       description:
//                           'Create a personal brand design and post templates for LinkedIn.',
//                       avatarPath: 'assets/images/avatar.png',
//                       onTap: () {
//                         Navigator.pushNamed(context,  AppRoutes.invitationDetails);
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//         // bottomNavigationBar:CustomBottomNav()

//       // bottomNavigationBar:  CustomBottomNav(cureentIndex: 3, userType: 'Provider',),
//     );
//   }
// }
