import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../domain/usecases/get_user_profile_info_usecase.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc
    extends Bloc<UserProfileEvent, UserProfileState> {
  GetUserProfileInfoUsecase getUserInfoUsecase;
  UserProfileBloc({required this.getUserInfoUsecase})
    : super(UserProfileInitial()) {
    on<GetUserProfileInfoEvent>(_onGetUserInfo);
  }

  FutureOr<void> _onGetUserInfo(
    GetUserProfileInfoEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    try {
      emit(UserProfileLoadingState());
      final result = await getUserInfoUsecase.call(event.userToken);
      emit(GotUserProfileInfoState(userInfo: result));
    } catch (e) {
      emit(
        UserProfileExceptionState(
          message: "unable to get Info : ${e.toString()}",
        ),
      );
    }
  }
}
