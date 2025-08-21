class JobModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final List<String> requirements;
  final List<String> skills;
  final String jobType; // Full Time / Part Time / Remote / Freelance
  final String workNature; // On-Site / Remote / Hybrid
  final double salary;
  final DateTime deadline;
  final String requesterId;
  final String status;

  JobModel({required this.status,
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.requirements,
    required this.skills,
    required this.jobType,
    required this.workNature,
    required this.salary,
    required this.deadline,
    required this.requesterId,
  });

factory JobModel.fromJson(Map<String, dynamic> json) {
  // Try to parse salary_range into a number
  double parsedSalary = 0.0;
  if (json['salary_range'] != null) {
    final salaryStr = json['salary_range'].toString();
    final match = RegExp(r'(\d+)').firstMatch(salaryStr);
    if (match != null) {
      parsedSalary = double.tryParse(match.group(1)!) ?? 0.0;
    }
  }

  return JobModel(
    id: json['id'].toString(),
    title: json['title'] ?? "",
    description: json['category'] ?? "", // fallback since API has no description
    location: "${json['city'] ?? ''}, ${json['country'] ?? ''}".trim(),
    requirements: List<String>.from(json['requirements'] ?? []), // API doesn’t send -> []
    skills: List<String>.from(json['skills'] ?? []),
    jobType: json['job_type'] ?? "",
    workNature: json['work_place'] ?? "",
    salary: parsedSalary,
    deadline: DateTime.parse(json['deadline']),
    requesterId: json['posted_by']?.toString() ?? "",
    status: json['status'] ?? "active", // fallback, since API doesn’t send
  );
}
  // factory JobModel.fromJson(Map<String, dynamic> json) {
  //   return JobModel(
  //     id: json['id'],
  //     title: json['title'],
  //     description: json['description'],
  //     location: json['location'],
  //     requirements: List<String>.from(json['requirements'] ?? []),
  //     skills: List<String>.from(json['skills'] ?? []),
  //     jobType: json['jobType'],
  //     workNature: json['workNature'],
  //     salary: (json['salary'] as num).toDouble(),
  //     deadline: DateTime.parse(json['deadline']),
  //     requesterId: json['requesterId'],
  //     status:json['status']
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'requirements': requirements,
      'skills': skills,
      'jobType': jobType,
      'workNature': workNature,
      'salary': salary,
      'deadline': deadline.toIso8601String(),
      'requesterId': requesterId,
      'status':status
    };
  }
}
