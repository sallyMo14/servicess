
import 'provider_company_model.dart';
import 'provider_solo_model.dart';
import 'requester_company_model.dart';
import 'requester_solo_model.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String role; // 'provider' or 'requester'
  final String accountType; // 'solo' or 'company'
  final dynamic profile; 

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.accountType,
    required this.profile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    dynamic profileData;

    if (json['role'] == 'provider' && json['accountType'] == 'company') {
      profileData = ProviderCompanyModel.fromJson(json['profile']);
    } else if (json['role'] == 'provider' && json['accountType'] == 'solo') {
      profileData = ProviderSoloModel.fromJson(json['profile']);
    } else if (json['role'] == 'requester' && json['accountType'] == 'company') {
      profileData = RequesterCompanyModel.fromJson(json['profile']);
    } else if (json['role'] == 'requester' && json['accountType'] == 'solo') {
      profileData = RequesterSoloModel.fromJson(json['profile']);
    }

    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      accountType: json['accountType'],
      profile: profileData,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'accountType': accountType,
        'profile': profile?.toJson(),
      };
}
