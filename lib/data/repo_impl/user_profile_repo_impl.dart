import '../data_sources/remote/user_info_remote_data_source.dart';
import '../repositories/user_profile_repo.dart';

class UserProfileRepoImpl implements UserProfileRepo {
  UserInfoRemoteDataSource userInfoRemoteDataSource;
  UserProfileRepoImpl({required this.userInfoRemoteDataSource});

  @override
  Future<Map<String, dynamic>> getUserInfo(String userToken) {
    return userInfoRemoteDataSource.getUserInfo(userToken);
  }
}
