import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  String? _token;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginButtonPressed>(_onLogin);
    on<LogoutPressed>(_onLogout);
    on<RegisterPressed>(_onRegister);
    on<VerifyCodePressed>(_onVerify);
  }

  Future<void> _onLogin(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await authRepository.login(
        event.email,
        event.password,
      );
      _token = result['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', _token!);
      await prefs.setString('user_type', result['userType']);

      emit(AuthSuccess(_token!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogout(
    LogoutPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.logout(_token!);

      // ⬇️ حذف التوكن
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');

      emit(LogoutSuccess());
    } catch (e) {
      emit(AuthFailure("Log out failed"));
    }
  }

  Future<void> _onRegister(
    RegisterPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final selectedServiceType = event.data['selectedServiceType'];

      if (selectedServiceType == 'company') {
        await authRepository.register(
          event.data,
        ); //registerWithCompanyData
      } else {
        await authRepository.register(
          event.data,
        ); //registerWithUserData
      }

      emit(AuthSuccess("Sing up success"));
    } catch (e) {
      emit(AuthFailure("Sign up failedss: ${e.toString()}"));
    }
  }

  Future<void> _onVerify(
    VerifyCodePressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final valid = await authRepository.verifyCode(
        event.email,
        event.code,
      );
      if (valid) {
        emit(VerificationSuccess());
      } else {
        emit(AuthFailure("Invalied Verification code "));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
