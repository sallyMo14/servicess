part of 'user_profile_bloc.dart';

abstract class UserProfileEvent {
  const UserProfileEvent();
}

class GetUserProfileInfoEvent extends UserProfileEvent {
  String userToken;
  GetUserProfileInfoEvent({required this.userToken});
}
