import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl =
      "http://10.0.2.2:8000/api"; // this is to make the emulator talk to the pc , the pcs host (http://127.0.0.1:8000/api)

  Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(
      //   "************************************************************************************************************************************************",
      // );
      // print(data);
      return {
        'token': data['token'],
        'userType':
            data['user']['user_role'], // Updated to match API response
      };
    } else {
      throw Exception("Login failed");
    }
  }

  Future<void> logout(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception("log out failed");
    }
  }

  // Updated to use single register endpoint
  Future<Map<String, dynamic>> register(
    Map<String, dynamic> data,
  ) async {
    Object encoddedData = jsonEncode(data);
    // print('***************************before go to the uri parse');
    // print(encoddedData);
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: encoddedData,
    );
    // print('***************************after go to the uri parse');
    // print(response.body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return {
        'message': responseData['message'],
        'verification_code': responseData['verification_code'],
      };
    } else {
      final error =
          jsonDecode(response.body)['message'] ??
          'Registration failed';
      throw Exception(error);
    }
  }

  // Updated endpoint name
  Future<bool> verifyCode(String email, String code) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-email'), // Fixed endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'code': code}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'] == 'Email verified';
    }

    throw Exception("Verification Failed");
  }
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AuthRepository {
//   final String baseUrl = "http://127.0.0.1:8000/api";// original: http://10.0.2.2:8000/api

//   Future<Map<String, dynamic>> login(
//     String email,
//     String password,
//   ) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return {
//         'token': data['token'],
//         'userType': data['userType'], // تأكد من الاسم حسب API
//       };
//     } else {
//       throw Exception("Login failed");
//     }
//   }

//   Future<void> logout(String token) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/logout'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode != 200) {
//       throw Exception("log out failed");
//     }
//   }

//   Future<void> registerWithCompanyData(
//     Map<String, dynamic> data,
//   ) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/register-company'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(data),
//     );

//     if (response.statusCode != 201) {
//       final error =
//           jsonDecode(response.body)['message'] ?? 'Login failed';
//       throw Exception(error);
//     }
//   }

//   Future<void> registerWithUserData(Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/register-solo'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(data),
//     );

//     if (response.statusCode != 200 && response.statusCode != 201) {
//       throw Exception('Sign up failed');
//     }
//   }

//   Future<bool> verifyCode(String email, String code) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/verify'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'code': code}),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['verified'] == true;
//     }

//     throw Exception("Verification Falied");
//   }
// }
