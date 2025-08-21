part of 'user_profile_bloc.dart';

abstract class UserProfileState {
  const UserProfileState();
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoadingState extends UserProfileState {}

class GotUserProfileInfoState extends UserProfileState {
  Map<String, dynamic> userInfo;

  GotUserProfileInfoState({required this.userInfo});
}

class UserProfileExceptionState extends UserProfileState {
  String message;
  UserProfileExceptionState({required this.message});
}
