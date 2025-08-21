class RequesterSoloModel {
  final String fullName;
  final int age;
  final String gender;
  final String email;
  final String phoneNumber;
  final String city;
  final String zipCode;
  final String jobTitle;
  final String password;

  RequesterSoloModel({
    required this.fullName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.zipCode,
    required this.jobTitle,
    required this.password,
  });

  factory RequesterSoloModel.fromJson(Map<String, dynamic> json) {
    return RequesterSoloModel(
      fullName: json['fullName'],
      age: json['age'],
      gender: json['gender'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      city: json['city'],
      zipCode: json['zipCode'],
      jobTitle: json['jobTitle'],
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
      'password': password,
    };
  }
}
