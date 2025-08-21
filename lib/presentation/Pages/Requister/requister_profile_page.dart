import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import '../../bloc/user_profile/user_profile_bloc.dart';
import '../../widgets/appear/info_row.dart';
import '../../widgets/appear/profile_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequesterProfilePage extends StatefulWidget {
  const RequesterProfilePage({super.key});

  @override
  State<RequesterProfilePage> createState() =>
      _RequesterProfilePageState();
}

class _RequesterProfilePageState extends State<RequesterProfilePage> {
  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print("-*****************--------------------$token");
    if (token != null && mounted) {
      print(
        "-*****************------------------after mounted--$token",
      );

      context.read<UserProfileBloc>().add(
        GetUserProfileInfoEvent(userToken: token),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GotUserProfileInfoState) {
            final allData = state.userInfo;
            final user = allData["user"];
            final profile = allData["profile"];
            final String selectedServiceType =
                user['account_type'] ?? '';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(
                    name:
                        profile['full_name'] ??
                        profile['company_name'],
                    jobTitle:
                        profile['job_title'] ?? profile['industry'],
                  ),
                  const SizedBox(height: 24),

                  Text(
                    selectedServiceType == 'solo'
                        ? 'Personal Info'
                        : 'Company Info',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (selectedServiceType == 'solo') ...[
                    InfoRow(
                      label: 'Age',
                      value: '${profile['age'] ?? ''}',
                    ),
                  ] else ...[
                    InfoDescription(
                      label: "Description",
                      value: profile['description'],
                    ),
                    // InfoRow(
                    //   label: 'Description',
                    //   value: '${profile['description'] ?? ''}',
                    // ),
                    InfoRow(
                      label: 'Year Of Establishment',
                      value:
                          '${profile['established_year'] ?? 'problem here'}',
                    ),
                    InfoRow(
                      label: 'Industry',
                      value: '${profile['industry'] ?? ''}',
                    ),
                  ],

                  const SizedBox(height: 24),
                  const Text(
                    'Contact Info',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  InfoRow(
                    label: 'Phone Number',
                    value: '${profile['phone'] ?? ''}',
                  ),
                  InfoRow(
                    label: 'Email',
                    value: '${user['email'] ?? ''}',
                  ),
                  InfoRow(
                    label: 'Location',
                    value: '${profile['city'] ?? ''}',
                  ),

                  const SizedBox(height: 150),
                ],
              ),
            );
          } else if (state is UserProfileExceptionState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
// ! newer old code
// class ProfilePage1 extends StatefulWidget {
//   final String userId;
//   const ProfilePage1({super.key, required this.userId});

//   @override
//   State<ProfilePage1> createState() => _ProfilePage1State();
// }

// class _ProfilePage1State extends State<ProfilePage1> {
//   PlatformFile? cvFile;
//   PlatformFile? portfolioFile;

//   @override
//   void initState() {
//     super.initState();
//     context.read<UserInfoBloc>().add(
//       GetUserInfoEvent(userId: widget.userId),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       // appBar: AppBar(
//       //   backgroundColor: AppColors.white,
//       //   elevation: 0,
//       //   leading: IconButton(
//       //     icon: const Icon(
//       //       Icons.arrow_back_ios,
//       //       color: AppColors.darkText,
//       //     ),
//       //     onPressed: () => Navigator.pop(context),
//       //   ),
//       //   centerTitle: true,
//       //   title: const Text(
//       //     'Account Info',
//       //     style: TextStyle(
//       //       color: AppColors.darkText,
//       //       fontWeight: FontWeight.bold,
//       //     ),
//       //   ),
//       //   actions: [
//       //     IconButton(
//       //       icon: const Icon(Icons.edit, color: AppColors.darkText),
//       //       onPressed: () {},
//       //     ),
//       //   ],
//       // ),
//       body: BlocBuilder<UserInfoBloc, UserInfoState>(
//         builder: (context, state) {
//           if (state is UserInfoLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is GotUserInfoState) {
//             final user = state.userInfo;

//             final String userType =
//                 user['userType']; // 'Provider' or 'Requester'
//             final String selectedServiceType =
//                 user['selectedServiceType']; // 'Solo' or 'Company'

//             return SingleChildScrollView(
//               padding: const EdgeInsets.all(24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ProfileHeader(
//                     name: user['fullName'],
//                     jobTitle: user['jobTitle'],
//                   ),
//                   const SizedBox(height: 24),

//                   Text(
//                     selectedServiceType == 'Solo'
//                         ? 'Personal Info'
//                         : 'Company Info',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   if (selectedServiceType == 'Solo') ...[
//                     InfoRow(label: 'Age', value: '${user['age']}'),
//                   ] else ...[
//                     InfoRow(
//                       label: 'Description',
//                       value: '${user['companyDesc']}',
//                     ),
//                     InfoRow(
//                       label: 'Year Of Establishment',
//                       value: '${user['companyEstablishment']}',
//                     ),
//                     InfoRow(
//                       label: 'Industry',
//                       value: '${user['companyIndustry']}',
//                     ),
//                   ],

//                   const SizedBox(height: 12),

//                   if (userType == 'Provider') ...[
//                     selectedServiceType == 'Solo'
//                         ? InfoRow(
//                           label: 'Year Of Experiences',
//                           value: '${user['experienceYears']} Years',
//                         )
//                         : InfoRow(
//                           label: 'Industry',
//                           value:
//                               '${user['companyIndustry'] ?? '2015'}',
//                         ),
//                     if (selectedServiceType == 'Solo')
//                       InfoRow(
//                         label: 'Education Level',
//                         value: '${user['educationLevel']}',
//                       ),
//                     const SizedBox(height: 24),
//                   ],

//                   const Text(
//                     'Contact Info',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 12),
//                   InfoRow(
//                     label: 'Phone number',
//                     value: '${user['phoneNumber']}',
//                   ),
//                   InfoRow(label: 'Email', value: '${user['email']}'),
//                   InfoRow(
//                     label: 'Location',
//                     value: '${user['location']}',
//                   ),

//                   const SizedBox(height: 24),

//                   if (userType == 'Provider') ...[
//                     Text(
//                       selectedServiceType == 'Company'
//                           ? 'Tax License'
//                           : 'CV',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     UploadBox(
//                       text:
//                           selectedServiceType == 'Company'
//                               ? 'Upload Your Tax License Here'
//                               : 'Upload Your CV Here',
//                       file: cvFile,
//                       onTap: () async {
//                         final result =
//                             await FilePicker.platform.pickFiles();
//                         if (result != null) {
//                           setState(() {
//                             cvFile = result.files.first;
//                           });
//                         }
//                       },
//                     ),

//                     const SizedBox(height: 24),
//                     const Text(
//                       'Portfolio',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 12),
//                     UploadBox(
//                       text: 'Upload Your Portfolio Here',
//                       file: portfolioFile,
//                       onTap: () async {
//                         final result =
//                             await FilePicker.platform.pickFiles();
//                         if (result != null) {
//                           setState(() {
//                             portfolioFile = result.files.first;
//                           });
//                         }
//                       },
//                     ),
//                     const SizedBox(height: 24),

//                     Text(
//                       selectedServiceType == 'Solo'
//                           ? 'Skills'
//                           : 'Fields',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     if (user['skills'] != null &&
//                         user['skills'] is List)
//                       Wrap(
//                         spacing: 10,
//                         runSpacing: 10,
//                         children:
//                             (user['skills'] as List)
//                                 .map(
//                                   (skill) => SkillChip(label: skill),
//                                 )
//                                 .toList(),
//                       ),
//                   ],
//                   const SizedBox(height: 150),
//                 ],
//               ),
//             );
//           } else if (state is UserInfoExceptionState) {
//             return Center(
//               child: Text(
//                 'Failed to load user info: ${state.message}',
//               ),
//             );
//           } else {
//             return const Center(child: Text('Something went wrong'));
//           }
//         },
//       ),
//     );
//   }
// }
// ! old code
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:servicess/presentation/bloc/user_info/user_info_bloc.dart';
// import 'package:servicess/presentation/widgets/appear/info_row.dart';

// import '../../../core/utils/app_colors.dart';
// import '../../widgets/appear/profile_header.dart';
// import '../../widgets/Inputs/skill_chip.dart';
// import '../../widgets/Inputs/upload_box.dart';

// class ProfilePage extends StatefulWidget {
//   String userId;
//    ProfilePage({super.key,required this.userId});


//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//     PlatformFile? cvFile;
//   PlatformFile? portfolioFile;
//   @override
//   void initState() {
// context.read<UserInfoBloc>().add(GetUserInfoEvent(userId: widget.userId));
//     super.initState();
//   }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: AppColors.white,
//     appBar: AppBar(
//       backgroundColor: AppColors.white,
//       elevation: 0,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText),
//         onPressed: () => Navigator.pop(context),
//       ),
//       centerTitle: true,
//       title: const Text(
//         'Account Info',
//         style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold),
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.edit, color: AppColors.darkText),
//           onPressed: () {},
//         ),
//       ],
//     ),
//     body: BlocBuilder<UserInfoBloc, UserInfoState>(
//       builder: (context, state) {
//         if (state is UserInfoLoadingState) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is GotUserInfoState) {
//           final user = state.userInfo;

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const ProfileHeader(),
//                 const SizedBox(height: 24),
//                 const Text('Personal Info', style: TextStyle(fontWeight: FontWeight.bold)),
//                 InfoRow(label: 'Age', value: '${user['age']} Years'),
//                 InfoRow(label: 'Year Of Experiences', value: '${user['experienceYears']} Years'),
//                 InfoRow(label: 'Education Level', value: user['educationLevel']),

//                 const SizedBox(height: 24),
//                 const Text('Contact Info', style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 12),
//                 InfoRow(label: 'Phone number', value: user['phoneNumber']),
//                 InfoRow(label: 'Email', value: user['email']),
//                 InfoRow(label: 'Location', value: user['location']),

//                 const SizedBox(height: 24),
//                 const Text('Cv', style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 12),
//                 UploadBox(
//                   text: 'Upload Your Cv Here',
//                   file: cvFile,
//                   onTap: () async {
//                     final result = await FilePicker.platform.pickFiles();
//                     if (result != null) {
//                       setState(() {
//                         cvFile = result.files.first;
//                       });
//                     }
//                   },
//                 ),

//                 const SizedBox(height: 24),
//                 const Text('Portfolio', style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 12),
//                 UploadBox(
//                   text: 'Upload Your Portfolio Here',
//                   file: portfolioFile,
//                   onTap: () async {
//                     final result = await FilePicker.platform.pickFiles();
//                     if (result != null) {
//                       setState(() {
//                         portfolioFile = result.files.first;
//                       });
//                     }
//                   },
//                 ),

//                 const SizedBox(height: 24),
//                 const Text('Skills', style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 12),
//                 Wrap(
//                   spacing: 10,
//                   runSpacing: 10,
//                   children: user['skills'].map((skill) => SkillChip(label: skill)).toList(),
//                 ),
//               ],
//             ),
//           );
//         } else if (state is UserInfoExceptionState) {
//           return Center(child: Text('Failed to load user info: ${state.message}'));
//         } else {
//           return const Center(child: Text('Something went wrong'));
//         }
//       },
//     ),
//   );
// }

// }