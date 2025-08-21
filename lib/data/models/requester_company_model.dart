class RequesterCompanyModel {
  final String companyName;
  final String industry;
  final int yearEstablished;
  final String taxLicense;
  final String size;
  final String description;
  final String email;
  final String phoneNumber;
  final String cityCountry;
  final String detailedAddress;
  final String posterCard;
  final String password;

  RequesterCompanyModel({
    required this.companyName,
    required this.industry,
    required this.yearEstablished,
    required this.taxLicense,
    required this.size,
    required this.description,
    required this.email,
    required this.phoneNumber,
    required this.cityCountry,
    required this.detailedAddress,
    required this.posterCard,
    required this.password,
  });

  factory RequesterCompanyModel.fromJson(Map<String, dynamic> json) {
    return RequesterCompanyModel(
      companyName: json['companyName'],
      industry: json['industry'],
      yearEstablished: json['yearEstablished'],
      taxLicense: json['taxLicense'],
      size: json['size'],
      description: json['description'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      cityCountry: json['cityCountry'],
      detailedAddress: json['detailedAddress'],
      posterCard: json['posterCard'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'industry': industry,
      'yearEstablished': yearEstablished,
      'taxLicense': taxLicense,
      'size': size,
      'description': description,
      'email': email,
      'phoneNumber': phoneNumber,
      'cityCountry': cityCountry,
      'detailedAddress': detailedAddress,
      'posterCard': posterCard,
      'password': password,
    };
  }
}
