// lib/domain/entities/register_request.dart
class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String role;
  final String type;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.type,
  });
}
