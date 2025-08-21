
class User {
  final int id;
  final String name;
  final String email;
  final String role; // provider / requester
  final String type; // solo / company

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.type,
  });
}
