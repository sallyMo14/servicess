class JobApplicationModel {
  final int jobId;
  final String providerId;
  final String answer1;
  final String answer2;
  final String answer3;

  JobApplicationModel({
    required this.jobId,
    required this.providerId,
    required this.answer1,
    required this.answer2,
    required this.answer3,
  });

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'provider_id': providerId,
      'answer_1': answer1,
      'answer_2': answer2,
      'answer_3': answer3,
    };
  }
}
