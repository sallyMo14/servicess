class EducationModel {
  final String level; // e.g. Bachelor, Master, PhD
  final String field;
  final String university;
  final int graduationYear;

  EducationModel({
    required this.level,
    required this.field,
    required this.university,
    required this.graduationYear,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      EducationModel(
        level: json['level'],
        field: json['field'],
        university: json['university'],
        graduationYear: json['graduationYear'],
      );

  Map<String, dynamic> toJson() => {
        'level': level,
        'field': field,
        'university': university,
        'graduationYear': graduationYear,
      };
}
