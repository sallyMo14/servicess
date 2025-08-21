// import 'package:dio/dio.dart';

// class UserInfoRemoteDataSource {
//   final Dio dio;

//   UserInfoRemoteDataSource({required this.dio});

//   Future<Map<String, dynamic>> getUserInfo(String userId) async {
//     try {
//       // Try to get user info through role-specific endpoints
//       final userData = await _getUserInfoFromRoleEndpoints();
      
//       if (userData != null) {
//         return _transformUserData(userData);
//       } else {
//         // Fallback to default data
//         return _getDefaultUserData(userId);
//       }
//     } catch (e) {
//       // Return default data if API calls fail
//       return _getDefaultUserData(userId);
//     }
//   }

//   Future<Map<String, dynamic>?> _getUserInfoFromRoleEndpoints() async {
//     final endpoints = [
//       '/solo-provider-action',
//       '/company-provider-action',
//       '/solo-seeker-action',
//       '/company-seeker-action'
//     ];

//     for (String endpoint in endpoints) {
//       try {
//         final res = await dio.post(endpoint, data: {
//           'action': 'get_profile'
//         });

//         if (res.statusCode == 200) {
//           return res.data;
//         }
//       } catch (e) {
//         continue;
//       }
//     }
//     return null;
//   }

//   Map<String, dynamic> _transformUserData(Map<String, dynamic> responseData) {
//     final user = responseData['user'] ?? {};
//     final profile = responseData['profile'] ?? responseData['company'] ?? {};
    
//     // Determine user type from endpoint or response
//     String userType = 'Provider';
//     String serviceType = 'Solo';
    
//     // You can determine this from the user data or endpoint
//     if (user['user_role'] != null) {
//       userType = _capitalizeFirst(user['user_role']);
//     }
//     if (user['account_type'] != null) {
//       serviceType = _capitalizeFirst(user['account_type']);
//     }

//     final Map<String, dynamic> transformedData = {
//       'userType': userType,
//       'selectedServiceType': serviceType,
//       'id': user['id']?.toString() ?? '',
//       'email': user['email'] ?? '',
//       'fullName': profile['full_name'] ?? '',
//       'age': profile['age']?.toString() ?? '',
//       'gender': profile['gender'] ?? '',
//       'phoneNumber': profile['phone'] ?? '',
//       'city': profile['city'] ?? '',
//       'zipCode': profile['zip_code'] ?? '',
//       'jobTitle': profile['job_title'] ?? '',
//       'experienceYears': profile['years_experience']?.toString() ?? '',
//       'educationLevel': profile['education_level'] ?? '',
//       'preferredWorkNature': profile['preferred_work_nature'] ?? '',
//       'skills': profile['skills'] ?? {},
//       'password': '', // Don't include password in response
//     };

//     // Add company-specific fields if it's a company user
//     if (serviceType == 'Company') {
//       transformedData.addAll({
//         'companyName': profile['company_name'] ?? '',
//         'industry': profile['industry'] ?? '',
//         'established': profile['established']?.toString() ?? '',
//         'taxLicense': profile['tax_license'] ?? '',
//         'companySize': profile['company_size'] ?? '',
//         'description': profile['description'] ?? '',
//         'postalCode': profile['postal_code'] ?? '',
//         'address': profile['address'] ?? '',
//       });
//     }

//     return transformedData;
//   }

//   Map<String, dynamic> _getDefaultUserData(String userId) {
//     return {
//       'userType': 'Provider',
//       'selectedServiceType': 'Solo',
//       'id': userId,
//       'fullName': "User Name",
//       'age': "23",
//       'gender': 'Female',
//       'email': 'account@gmail.com',
//       'phoneNumber': '0599998887',
//       'city': 'Gaza',
//       'zipCode': '123456',
//       'jobTitle': 'user Job',
//       'experienceYears': '2',
//       'educationLevel': 'Bachelor\'s',
//       'preferredWorkNature': 'Part-Time',
//       'skills': {'Skill1': 'java', 'Skill2': 'C++'},
//       'password': '',
//     };
//   }

//   String _capitalizeFirst(String text) {
//     if (text.isEmpty) return text;
//     return text[0].toUpperCase() + text.substring(1).toLowerCase();
//   }
// }

import 'dart:convert';

import 'package:http/http.dart' as http;

class UserInfoRemoteDataSource {
  final String baseUrl =
      "http://10.0.2.2:8000";
Future<Map<String, dynamic>> getUserInfo(String userToken) async {
  try {
    final url = Uri.parse('$baseUrl/api/profile');
    print(" Calling: $url");
    print(" Token: $userToken");

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $userToken',
      },
    );

    // print(" Status: ${response.statusCode}");
    // print(" Body: ${response.body}");

    if (response.statusCode == 200) {
      
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Failed to load user info. Status: ${response.statusCode}, Body: ${response.body}',
      );
    }
  } catch (e) {
    throw Exception('Error fetching user info: $e');
  }
}

  // Future<Map<String, dynamic>> getUserInfo(String userToken) async {
  // try {
  //   print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++in data soutce the token is $userToken");
  //   final response = await http.get(
  //     Uri.parse('$baseUrl/api/profile'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $userToken',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     // Successful request
  //     return jsonDecode(response.body);
  //   } else {
  //     // Request failed
  //     throw Exception(
  //       'Failed to load user info. Status: ${response.statusCode}, Body: ${response.body}',
  //     );
  //   }
  // } catch (e) {
  //   throw Exception('Error fetching user info: $e');
  // }
  // }
}
