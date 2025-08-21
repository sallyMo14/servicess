class ProviderSoloModel {
  final String fullName;
  final int age;
  final String gender;
  final String email;
  final String phoneNumber;
  final String city;
  final String zipCode;
  final String jobTitle;
  final int experienceYears;
  final String educationLevel;
  final String preferredWorkNature;
  final List<String> skills;
  final String password;

  ProviderSoloModel({
    required this.fullName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.zipCode,
    required this.jobTitle,
    required this.experienceYears,
    required this.educationLevel,
    required this.preferredWorkNature,
    required this.skills,
    required this.password,
  });

  factory ProviderSoloModel.fromJson(Map<String, dynamic> json) {
    return ProviderSoloModel(
      fullName: json['fullName'],
      age: json['age'],
      gender: json['gender'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      city: json['city'],
      zipCode: json['zipCode'],
      jobTitle: json['jobTitle'],
      experienceYears: json['experienceYears'],
      educationLevel: json['educationLevel'],
      preferredWorkNature: json['preferredWorkNature'],
      skills: List<String>.from(json['skills'] ?? []),
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'zipCode': zipCode,
      'jobTitle': jobTitle,
      'experienceYears': experienceYears,
      'educationLevel': educationLevel,
      'preferredWorkNature': preferredWorkNature,
      'skills': skills,
      'password': password,
    };
  }
}
