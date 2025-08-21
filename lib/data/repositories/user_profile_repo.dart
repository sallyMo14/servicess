abstract class UserProfileRepo {
  // ! i put it as dynamic or Map ,since we have  users as requesters , providers  also solo , or compnay
  // ! new commnet : this repo and bloc(userInfo) now is just for profile page
  Future<Map<String, dynamic>> getUserInfo(String userToken);
}
