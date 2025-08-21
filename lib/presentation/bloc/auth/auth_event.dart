abstract class AuthEvent {}



class LogoutPressed extends AuthEvent {} 
class RegisterPressed extends AuthEvent {
  final Map<String, dynamic> data;

  RegisterPressed(this.data);
}



class VerifyCodePressed extends AuthEvent {
  final String email;
  final String code;

  VerifyCodePressed({required this.email, required this.code});
}
class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}

