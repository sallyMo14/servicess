
// import 'package:dio/dio.dart';
// import 'package:servicess/data/models/user_model.dart';

// import 'auth_remote_data_source.dart';

// class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
//   final Dio dio;

//   AuthRemoteDataSourceImpl(this.dio);

//   @override
//   Future<UserModel> login(String email, String password) async {
//     final res = await dio.post('/login', data: {
//       'email': email,
//       'password': password,
//     });
//     return UserModel.fromJson(res.data['user']);
//   }

//   @override
//   Future<UserModel> register(Map<String, dynamic> data) async {
//     final res = await dio.post('/register', data: data);
//     return UserModel.fromJson(res.data['user']);
//   }

//   @override
//   Future<void> logout() async {
//     await dio.post('/logout');
//   }

//   @override
//   Future<UserModel?> checkAuthStatus() async {
//     final res = await dio.get('/me');
//     return res.statusCode == 200
//         ? UserModel.fromJson(res.data)
//         : null;
//   }
// }
