import '../../data/repositories/user_profile_repo.dart';

class GetUserProfileInfoUsecase {
  UserProfileRepo userInfoRepo;
  GetUserProfileInfoUsecase({required this.userInfoRepo});
  Future<Map<String, dynamic>> call(String userToken) {
    return userInfoRepo.getUserInfo(userToken);
  }
}
