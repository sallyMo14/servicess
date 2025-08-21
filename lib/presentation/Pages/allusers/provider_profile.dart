import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sally_service4/core/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/user_profile/user_profile_bloc.dart';
import '../../widgets/appear/info_row.dart';
import '../../widgets/appear/profile_header.dart';
import '../../widgets/Inputs/skill_chip.dart';
import '../../widgets/Inputs/upload_box.dart';

class ProviderProfilePage extends StatefulWidget {
  const ProviderProfilePage({super.key});

  @override
  State<ProviderProfilePage> createState() => _ProviderProfilePageState();
}

class _ProviderProfilePageState extends State<ProviderProfilePage> {
  PlatformFile? cvFile;
  PlatformFile? portfolioFile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print("------TOKEN PROVIDER------ $token");
    if (token != null && mounted) {
      context.read<UserProfileBloc>().add(
            GetUserProfileInfoEvent(userToken: token),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Provider Info',
          style: TextStyle(
            color: AppColors.darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GotUserProfileInfoState) {
            final allData = state.userInfo;
            final user = allData["user"];
            final profile = allData["profile"];
            final String selectedServiceType = user['account_type'] ?? '';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(
                    name: profile['full_name'] ?? profile['company_name'],
                    jobTitle: profile['job_title'] ?? profile['industry'],
                  ),
                  const SizedBox(height: 24),

                  Text(
                    selectedServiceType == 'solo'
                        ? 'Personal Info'
                        : 'Company Info',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  if (selectedServiceType == 'solo') ...[
                    InfoRow(
                      label: 'Age',
                      value: '${profile['age'] ?? ''}',
                    ),
                    InfoRow(
                      label: 'Year Of Experience',
                      value: '${profile['years_of_experience'] ?? ''} Years',
                    ),
                    InfoRow(
                      label: 'Education Level',
                      value: '${profile['education_level'] ?? ''}',
                    ),
                  ] else ...[
                    InfoDescription(
                      label: "Description",
                      value: profile['description'] ?? '',
                    ),
                    InfoRow(
                      label: 'Year Of Establishment',
                      value: '${profile['established_year'] ?? ''}',
                    ),
                    InfoRow(
                      label: 'Industry',
                      value: '${profile['industry'] ?? ''}',
                    ),
                  ],

                  const SizedBox(height: 24),
                  const Text('Contact Info',
                      style: TextStyle(fontWeight: FontWeight.bold)),
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

                  const SizedBox(height: 24),
                  Text(
                    selectedServiceType == 'company'
                        ? 'Tax License'
                        : 'CV',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  UploadBox(
                    text: selectedServiceType == 'company'
                        ? 'Upload Your Tax License Here'
                        : 'Upload Your CV Here',
                    file: cvFile,
                    onTap: () async {
                      final result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        setState(() {
                          cvFile = result.files.first;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 24),
                  const Text('Portfolio',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  UploadBox(
                    text: 'Upload Your Portfolio Here',
                    file: portfolioFile,
                    onTap: () async {
                      final result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        setState(() {
                          portfolioFile = result.files.first;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 24),
                  Text(
                    selectedServiceType == 'solo' ? 'Skills' : 'Fields',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (profile['skills'] != null &&
                      profile['skills'] is List)
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: (profile['skills'] as List)
                          .map((skill) => SkillChip(label: skill))
                          .toList(),
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

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:servicess/presentation/bloc/user_profile/user_profile_bloc.dart';
// import 'package:servicess/presentation/widgets/appear/custom_bottom_nav.dart';
// import 'package:servicess/presentation/widgets/appear/profile_header.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../core/utils/app_colors.dart';
// import '../../widgets/appear/info_row.dart';
// import '../../widgets/Inputs/skill_chip.dart';
// import '../../widgets/Inputs/upload_box.dart';
// // ignore: depend_on_referenced_packagesظ
// // import 'package:file_picker/file_picker.dart';
// // import '../../core/theme/app_colors.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:servicess/core/utils/app_colors.dart';
// import 'package:servicess/presentation/widgets/appear/info_row.dart';
// import 'package:servicess/presentation/widgets/appear/profile_header.dart';
// import 'package:servicess/presentation/widgets/Inputs/skill_chip.dart';
// import 'package:servicess/presentation/widgets/Inputs/upload_box.dart';

// class ProviderProfilePage extends StatefulWidget {

//   const ProviderProfilePage({super.key});

//   @override
//   State<ProviderProfilePage> createState() => _ProviderProfilePageState();
// }

// class _ProviderProfilePageState extends State<ProviderProfilePage> {
//   PlatformFile? cvFile;
//   PlatformFile? portfolioFile;

//   @override
//   Widget build(BuildContext context) {
//      Future<void> _loadUserProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('auth_token');
//     print("-*****************--------------------$token");
//     if (token != null && mounted) {
//       print(
//         "-*****************------------------after mounted--$token",
//       );

//       context.read<UserProfileBloc>().add(
//         GetUserProfileInfoEvent(userToken: token),
//       );
//     }
//   }
//     final String selectedServiceType = widget.user['selectedServiceType']; // Solo or Company

//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         title: const Text(
//           'Provider Info',
//           style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ProfileHeader(
//               name: widget.user['fullName'],
//               jobTitle: widget.user['jobTitle'],
//             ),
//             const SizedBox(height: 24),

//             Text(
//               selectedServiceType == 'Solo' ? 'Personal Info' : 'Company Info',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),

//             if (selectedServiceType == 'Solo') ...[
//               InfoRow(label: 'Age', value: '${widget.user['age']}'),
//               InfoRow(label: 'Year Of Experience', value: '${widget.user['experienceYears']} Years'),
//               InfoRow(label: 'Education Level', value: '${widget.user['educationLevel']}'),
//             ] else ...[
//               InfoRow(label: 'Description', value: '${widget.user['companyDesc']}'),
//               InfoRow(label: 'Year Of Establishment', value: '${widget.user['companyEstablishment']}'),
//               InfoRow(label: 'Industry', value: '${widget.user['companyIndustry']}'),
//             ],

//             const SizedBox(height: 24),
//             const Text('Contact Info', style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             InfoRow(label: 'Phone Number', value: '${widget.user['phoneNumber']}'),
//             InfoRow(label: 'Email', value: '${widget.user['email']}'),
//             InfoRow(label: 'Location', value: '${widget.user['location']}'),

//             const SizedBox(height: 24),
//             Text(selectedServiceType == 'Company' ? 'Tax License' : 'CV',
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             UploadBox(
//               text: selectedServiceType == 'Company'
//                   ? 'Upload Your Tax License Here'
//                   : 'Upload Your CV Here',
//               file: cvFile,
//               onTap: () async {
//                 final result = await FilePicker.platform.pickFiles();
//                 if (result != null) {
//                   setState(() {
//                     cvFile = result.files.first;
//                   });
//                 }
//               },
//             ),

//             const SizedBox(height: 24),
//             const Text('Portfolio', style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             UploadBox(
//               text: 'Upload Your Portfolio Here',
//               file: portfolioFile,
//               onTap: () async {
//                 final result = await FilePicker.platform.pickFiles();
//                 if (result != null) {
//                   setState(() {
//                     portfolioFile = result.files.first;
//                   });
//                 }
//               },
//             ),

//             const SizedBox(height: 24),
//             Text(selectedServiceType == 'Solo' ? 'Skills' : 'Fields',
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             if (widget.user['skills'] != null && widget.user['skills'] is List)
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: (widget.user['skills'] as List)
//                     .map((skill) => SkillChip(label: skill))
//                     .toList(),
//               ),

//             const SizedBox(height: 150),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ! newer older code
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   PlatformFile? cvFile;
//   PlatformFile? portfolioFile;
//   late String userType;
//   late String selectedServiceType;
//   late String location;
//   late String phoneNumber;
//   late String ProviderEduLevel;
//   late String email;
//   late String companyIndusrty;
//   late String providerExperince;
//   late String companyEstablishment;
//   late String companyDesc;
//   late String soloAge;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final args = ModalRoute.of(context)?.settings.arguments;
//     if (args != null && args is Map) {
//       // here edit if one of those are int , or float ,
//       location = args['location'];
//       email = args['email'];
//       phoneNumber = args['phoneNumber'];
//       ProviderEduLevel = args['ProviderEduLevel'];
//       companyIndusrty = args['companyIndusrty'];
//       providerExperince = args['providerExperince'];
//       companyDesc = args['companyDesc'];
//       companyEstablishment = args['companyEstablishment'];
//       soloAge = args['soloAge'];

//       userType = args['userType'];
//       selectedServiceType = args['selectedServiceType'];
//     } else {
//       // default values to test the page
//       location = 'Gaza';
//       email = 'email@gmail.com';
//       phoneNumber = '0123456789';
//       ProviderEduLevel = 'Bacelor\'s';
//       companyIndusrty = 'finance';
//       providerExperince = '3 years';
//       companyDesc = 'no desc for now';
//       companyEstablishment = '2015';
//       soloAge = '25 years';
//       userType = 'requester';
//       selectedServiceType = 'Company';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back_ios,
//             color: AppColors.darkText,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         title: const Text(
//           'Account Info',
//           style: TextStyle(
//             color: AppColors.darkText,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit, color: AppColors.darkText),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // Profile Section
//             ProfileHeader(),
//             const SizedBox(height: 24),

//             // Personal Info
//             if (selectedServiceType == 'Solo') ...[
//               const Text(
//                 'Personal Info',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),

//               selectedServiceType == 'Solo'
//                   ? InfoRow(label: 'Age', value: soloAge)
//                   : InfoRow(
//                     label: 'Year Of stablishment',
//                     value: companyEstablishment,
//                   ),
//             ] else ...[
//               const Text(
//                 'Company Info',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               InfoRow(label: 'Description', value: companyDesc),
//               InfoRow(
//                 label: 'Year Of stablishment',
//                 value: companyEstablishment,
//               ),
//               InfoRow(label: 'Indusrty', value: companyIndusrty),
//             ],

//             if (userType == 'Provider') ...[
//               selectedServiceType == 'Solo'
//                   ? InfoRow(
//                     label: 'Year Of Experiences',
//                     value: providerExperince,
//                   )
//                   : InfoRow(
//                     label: 'Indusrty',
//                     value: companyIndusrty,
//                   ),
//               if (selectedServiceType == 'Solo')
//                 InfoRow(
//                   label: 'Education Level',
//                   value: ProviderEduLevel,
//                 ),
//             ],

//             const SizedBox(height: 24),

//             // Contact Info
//             const Text(
//               'Contact Info',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 12),
//             InfoRow(label: 'Phone number', value: phoneNumber),
//             InfoRow(label: 'Email', value: email),
//             InfoRow(label: 'Location', value: location),

//             const SizedBox(height: 24),

//             // CV Upload
//             if (userType == 'Provider') ...[
//               if (selectedServiceType == 'Company') ...[
//                 const Text(
//                   'Tax licsnce',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 12),
//                 UploadBox(
//                   text: 'Upload Your Tax licsnce Here',
//                   file: cvFile,
//                   onTap: () async {
//                     final result =
//                         await FilePicker.platform.pickFiles();
//                     if (result != null) {
//                       setState(() {
//                         cvFile = result.files.first;
//                       });
//                     }
//                   },
//                 ),
//               ] else ...[
//                 const Text(
//                   'Cv',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 12),
//                 UploadBox(
//                   text: 'Upload Your Cv Here',
//                   file: cvFile,
//                   onTap: () async {
//                     final result =
//                         await FilePicker.platform.pickFiles();
//                     if (result != null) {
//                       setState(() {
//                         cvFile = result.files.first;
//                       });
//                     }
//                   },
//                 ),
//               ],

//               const SizedBox(height: 24),

//               // Portfolio Upload
//               const Text(
//                 'Portfolio',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 12),
//               UploadBox(
//                 text: 'Upload Your Portfolio Here',
//                 file: portfolioFile,
//                 onTap: () async {
//                   final result =
//                       await FilePicker.platform.pickFiles();
//                   if (result != null) {
//                     setState(() {
//                       portfolioFile = result.files.first;
//                     });
//                   }
//                 },
//               ),
//               const SizedBox(height: 24),

//               // Skills
//               selectedServiceType == 'Solo'
//                   ? const Text(
//                     'Skills',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   )
//                   : const Text(
//                     'feilds',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//               const SizedBox(height: 12),
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: const [
//                   // here i cant make List here before making sure that i got skills (not null skills)
//                   SkillChip(label: 'Graphic'),
//                   SkillChip(label: 'Art'),
//                   SkillChip(label: 'ASP.Net'),
//                   SkillChip(label: 'PHP'),
//                   SkillChip(label: 'UI/UX'),
//                   SkillChip(label: 'Css'),
//                   SkillChip(label: 'HTML 5'),
//                 ],
//               ),
//               const SizedBox(height: 32),
//             ],
//             const SizedBox(height: 150),
//           ],
//         ),
//       ),
//       // bottomNavigationBar:CustomBottomNav()
//       // bottomNavigationBar: CustomBottomNav(cureentIndex: 1, userType: userType,),
//     );
//   }
// }


// ! old code
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:servicess/presentation/widgets/appear/custom_bottom_nav.dart';
// import 'package:servicess/presentation/widgets/appear/profile_header.dart';


// import '../../../core/utils/app_colors.dart';
// import '../../widgets/appear/info_row.dart';
// import '../../widgets/Inputs/skill_chip.dart';
// import '../../widgets/Inputs/upload_box.dart';
// // ignore: depend_on_referenced_packagesظ
// // import 'package:file_picker/file_picker.dart';
// // import '../../core/theme/app_colors.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   PlatformFile? cvFile;
//   PlatformFile? portfolioFile;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         title: const Text(
//           'Account Info',
//           style: TextStyle(color: AppColors.darkText, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit, color:AppColors.darkText),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Profile Section

//             const ProfileHeader(),

//             const SizedBox(height: 24),

//             // Personal Info
//             const Text('Personal Info',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             const InfoRow(label: 'Age', value: '20 Years'),
//             const InfoRow(label: 'Year Of Experiences', value: '3 Years'),
//             const InfoRow(label: 'Education Level', value: "Bachelor's"),

//             const SizedBox(height: 24),

//             // Contact Info
//             const Text('Contact Info',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             const InfoRow(label: 'Phone number', value: '+966 50 4567 666'),
//             const InfoRow(label: 'Email', value: 'AhmedAli@gmail.com'),
//             const InfoRow(label: 'Location', value: 'Palestine - Gaza'),

//             const SizedBox(height: 24),

//             // CV Upload
//             const Text('Cv', style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             UploadBox(
//               text: 'Upload Your Cv Here',
//               file: cvFile,
//               onTap: () async {
//                 final result = await FilePicker.platform.pickFiles();
//                 if (result != null) {
//                   setState(() {
//                     cvFile = result.files.first;
//                   });
//                 }
//               },
//             ),

//             const SizedBox(height: 24),

//             // Portfolio Upload
//             const Text('Portfolio',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             UploadBox(
//               text: 'Upload Your Portfolio Here',
//               file: portfolioFile,
//               onTap: () async {
//                 final result = await FilePicker.platform.pickFiles();
//                 if (result != null) {
//                   setState(() {
//                     portfolioFile = result.files.first;
//                   });
//                 }
//               },
//             ),

//             const SizedBox(height: 24),

//             // Skills
//             const Text('Skills', style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 12),
//             const Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: [
//                 SkillChip(label: 'Graphic'),
//                 SkillChip(label: 'Art'),
//                 SkillChip(label: 'ASP.Net'),
//                 SkillChip(label: 'PHP'),
//                 SkillChip(label: 'UI/UX'),
//                 SkillChip(label: 'Css'),
//                 SkillChip(label: 'HTML 5'),
//               ],
//             ),
//             const SizedBox(height: 32),
//             const CustomBottomNav(),
//           ],
//         ),
//       ),
//     );
//   }
// }
