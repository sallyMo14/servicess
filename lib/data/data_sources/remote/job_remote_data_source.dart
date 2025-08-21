import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sally_service4/domain/core/user_kinds.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/job_application_model.dart';
import '../../models/job_model.dart';

class JobRemoteDataSource {
  final String baseUrl;
  JobRemoteDataSource({required this.baseUrl});

  Future<Map<String, String>> _headers({bool auth = false}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (auth) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<List<JobModel>> getHomeJobs({
    required String userId,
    required String userType,
    required String entityType,
  }) async {
    final res = await http.get(
      Uri.parse(
        '$baseUrl/home-jobs?userId=$userId&userType=$userType&entityType=$entityType',
      ),
      headers: await _headers(auth: true),
    );

    if (res.statusCode != 200) {
      throw Exception(
        'get home jobs failed (${res.statusCode}): ${res.body}',
      );
    }
    final List list = jsonDecode(res.body);

    return list.map<JobModel>((j) => JobModel.fromJson(j)).toList();
  }

  // ==== POST A JOB ====
  Future<void> postJob(Map<String, dynamic> jobData) async {
    print(
      "------------- Now we are at post job method----------------",
    );

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print("----------- token in post job is  $token");
    final res = await http.post(
      Uri.parse('$baseUrl/jobs'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (token != null && token.isNotEmpty)
          'Authorization': 'Bearer $token',
      },
      body: jsonEncode(jobData),
    );

    print("------------- ${res.statusCode}----------------");
    if (res.statusCode != 200 &&
        res.statusCode != 201 &&
        res.statusCode != 202) {
      throw Exception(
        'Post job failed (${res.statusCode}): ${res.body}',
      );
    }
  }
  // Future<void> postJob(Map<String, dynamic> jobData) async {
  //   print(
  //     "------------- Now we are at post job method----------------",
  //   );
  //   final res = await http.post(
  //     Uri.parse('$baseUrl/jobs'),
  //     headers: await _headers(auth: true),
  //     body: jsonEncode(jobData),
  //   );
  //       print(
  //     "------------- ${res.statusCode}----------------",
  //   );
  //   if (res.statusCode != 202) {
  //     throw Exception(
  //       'tset fail post job (${res.statusCode}): ${res.body}',
  //     );
  //   }
  // }

  Future<void> applyToJob(JobApplicationModel application) async {
    Map<String, dynamic> answers = {
      "answers": [
        application.answer1,
        application.answer2,
        application.answer3,
      ],
    };
    final res = await http.post(
      Uri.parse('$baseUrl/jobs/${application.jobId}/apply'),
      headers: await _headers(auth: true),
      body: jsonEncode(answers),
    );
    if (res.statusCode != 200 &&
        res.statusCode != 202 &&
        res.statusCode != 201) {
      throw Exception(
        'apply failed (${res.statusCode}): ${res.body}',
      );
    }
  }

  Future<List<JobModel>> getJobsByUserType(String userType) async {
    print("111 -- entered getJobsByUserType");

    final headers = await _headers(auth: true);
    print("222 -- headers ready: $headers");

    final url = '$baseUrl/jobs';
    print("333 -- requesting: $url");

    final res = await http.get(Uri.parse(url), headers: headers);
    print("444 -- got response with status: ${res.statusCode}");

    if (res.statusCode != 200) {
      print("555 -- error response: ${res.body}");
      throw Exception(
        'get jobs failed (${res.statusCode}): ${res.body}',
      );
    }
    print("666 -- check body: ${res.body}");

    final decoded = jsonDecode(res.body);
    final List list = decoded['data'];

    print("777 -- jobs list: $list");

    return list.map<JobModel>((j) => JobModel.fromJson(j)).toList();
  }

  // Future<List<JobModel>> getJobsByUserType(String userType) async {
  //       print("111111111111111111111111111111111111111111111111111111111111111111111111111111111111welcom in getJobsByUserType");

  //   final res = await http.get(
  //     Uri.parse('$baseUrl/jobs'),
  //     headers: await _headers(auth: true),
  //   );
  //   if (res.statusCode != 200) {
  //   print("222222222222222222222222222222222222222222222222222222222222222222222222222222222222 throw exception${res.statusCode}");

  //     throw Exception(
  //       'get jobs failed (${res.statusCode}): ${res.body}',
  //     );
  //   }
  //   print(
  //     "222222222222222222222222222222222222222222222222222222222 ${res.statusCode}",
  //   );

  //   final List list = jsonDecode(res.body);
  //   print(
  //     "222222222222222222222222222222222222222222222222222222222 ${list}",
  //   );

  //   return list.map<JobModel>((j) => JobModel.fromJson(j)).toList();
  // }

  Future<List<JobModel>> getMyJobs(
    String userId,
    String userType,
  ) async {
    final res = await http.get(
      Uri.parse('$baseUrl/my-jobs?userId=$userId&userType=$userType'),
      headers: await _headers(auth: true),
    );
    if (res.statusCode != 200) {
      throw Exception(
        'get my jobs failed (${res.statusCode}): ${res.body}',
      );
    }
    final List list = jsonDecode(res.body);
    return list.map<JobModel>((j) => JobModel.fromJson(j)).toList();
  }
}
