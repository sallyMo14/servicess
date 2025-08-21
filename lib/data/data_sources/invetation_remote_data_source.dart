// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:dio/dio.dart'; // still keep it
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InvetationRemoteDataSource {
  final Dio dio; // not used, but kept for consistency

  InvetationRemoteDataSource({required this.dio} );

  Future<Map<String, dynamic>> getInvitations(String userId) async {
    try {
          final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    
      final url = Uri.parse("http://10.0.2.2:8000/api/invitations");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          'Authorization': 'Bearer $token', // 👈 send token here

        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map<String, dynamic>) {
          return data;
        }
      }
      return _getDefaultInvitation();
    } catch (e) {
      return _getDefaultInvitation();
    }
  }

  Map<String, dynamic> _getDefaultInvitation() {
    return {
      "id": "0",
      "title": "No invitations available",
      "location": "",
      "deadline": "",
      "status": "none",
    };
  }
}

// class InvetationRemoteDataSource {
//   final Dio dio;
// final String _baseUrl = "http://10.0.2.2:8000/api"; 
//   InvetationRemoteDataSource({required this.dio});


//   Future<Map<String, dynamic>> getInvitations(String userId) async {
//     try {
//       final url = Uri.parse("$_baseUrl/invitations");

//       final response = await http.get(
//         url,
//         headers: {
//           "Content-Type": "application/json",
//           "Accept": "application/json",
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Ensure it's a Map
//         if (data is Map<String, dynamic>) {
//           return data;
//         } else {
//           return _getDefaultInvitation();
//         }
//       } else {
//         return _getDefaultInvitation();
//       }
//     } catch (e) {
//       return _getDefaultInvitation();
//     }
//   }
//   // Future<Map<String, dynamic>> getInvitations(String userId) async {
//   //   try {
//   //     // Get jobs that the user can apply to (for providers)
//   //     // or jobs posted by the user (for seekers)
//   //     final jobs = await _getJobsForUser(userId);
      
//   //     if (jobs.isNotEmpty) {
//   //       final job = jobs.first; // Get the first job as an example
//   //       return _transformJobToInvitation(job);
//   //     } else {
//   //       return _getDefaultInvitation();
//   //     }
//   //   } catch (e) {
//   //     // Return default invitation if API calls fail
//   //     return _getDefaultInvitation();
//   //   }
//   // }

//   Future<List<Map<String, dynamic>>> _getJobsForUser(String userId) async {
//     try {
//       // Get all jobs from the backend
//       final res = await dio.get('/jobs');
      
//       if (res.statusCode == 200) {
//         final List<dynamic> jobsData = res.data['jobs'] ?? [];
//         return jobsData.cast<Map<String, dynamic>>();
//       }
//       return [];
//     } catch (e) {
//       return [];
//     }
//   }

//   Map<String, dynamic> _transformJobToInvitation(Map<String, dynamic> job) {
//     final user = job['user'] ?? {};
//     final skills = job['skills'] ?? [];
    
//     return {
//       'requesterId': user['id']?.toString() ?? 'default requester',
//       'jobName': job['title'] ?? 'Flutter dev',
//       'jobDescription': 'Job description from backend', // You might want to add this field to your backend
//       'jobReq': [
//         'Experience: ${job['experience_from']}-${job['experience_to']} years',
//         'Work Place: ${job['work_place']}',
//         'Job Type: ${job['job_type']}',
//         'Location: ${job['city']}, ${job['country']}',
//       ],
//       'ReqSkills': skills.map<String>((skill) => skill['skill'] ?? '').toList(),
//       'salary': job['salary_range'] ?? 'Money\$',
//       'applicationDeadline': job['deadline'] ?? 'Day/Month/Year',
//       'jobStatus': _determineJobStatus(job),
//       'jobId': job['id']?.toString() ?? '',
//     };
//   }

//   String _determineJobStatus(Map<String, dynamic> job) {
//     final deadline = job['deadline'];
//     if (deadline != null) {
//       final deadlineDate = DateTime.parse(deadline);
//       if (DateTime.now().isAfter(deadlineDate)) {
//         return 'expired';
//       }
//     }
//     return 'pending';
//   }

//   Map<String, dynamic> _getDefaultInvitation() {
//     return {
//       'requesterId': 'default requester',
//       'jobName': 'Flutter dev',
//       'jobDescription': 'i need you to make an app that have 123.....',
//       'jobReq': [
//         '+2 years of experience',
//         'made at least 5 projects',
//         'fluent in english',
//         'ability to work with team',
//         'ability to work under pressure',
//         'handle bugs and problems',
//       ],
//       'ReqSkills': ['leader', 'problem solver', 'skill3', 'skill4'],
//       'salary': 'Money\$',
//       'applicationDeadline': 'Day/Month/Year',
//       'jobStatus': 'pending',
//     };
//   }

//   Future<void> acceptInvitation(String invId) async {
//     try {
//       // Apply for the job using the job ID
//       await dio.post('/jobs/$invId/apply', data: {
//         'answers': {
//           'default_answer': 'I accept this invitation'
//         }
//       });
//     } catch (e) {
//       throw Exception('Failed to accept invitation: $e');
//     }
//   }

//   Future<void> rejectInvitation(String invId) async {
//     try {
//       // You might want to add a reject endpoint to your backend
//       // For now, we'll just log the rejection
//       print('Invitation $invId rejected');
//     } catch (e) {
//       throw Exception('Failed to reject invitation: $e');
//     }
//   }
// }
// // ! old code
// // class InvetationRemoteDataSource {
// //   Future<Map<String, dynamic>> getInvetations(String userId) async {
// //     //? do your magic (call the job data and the requester who sent it )
// //     return {
// //       'requesterId': 'default requester',
// //       'jopName': 'Flutter dev',
// //       'job descreption':
// //           'i need you to make an app that have 123.....',
// //       'jobReq': [
// //         '+2 years of expereince',
// //         'made at least 5 projects',
// //         'fluent in english',
// //         'ability to work with team',
// //         'ability to work under pressure',
// //         'handle bugs and problems',
// //       ],
// //       'ReqSkills': ['leader', 'probelm solver', 'skill3', 'skill4'],
// //       'salary': 'Money\$',
// //       'applicationDeadline': 'Day/Month/Year',
// //       'jobStatus':
// //           'pending', // if he accept then change to accept , same if reject , and if deadline came , then put 'expiered'
// //     };
// //   }
// //   Future<void> acceptInvetation(String invId)async{
// //     //? accept the invetation
// //   }
// //   Future<void> rejectInvetation(String invId)async{
// //     //? reject the invetation
// //   }
// // }
