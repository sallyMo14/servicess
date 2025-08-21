// lib/data/models/job_form_storage.dart

class JobFormStorage {
  static final JobFormStorage _instance = JobFormStorage._internal();

  factory JobFormStorage() => _instance;

  JobFormStorage._internal();

  final JobFormData jobData = JobFormData();
}

class JobFormData {
  String title = '';
  String category = '';
  String country = '';
  String city = '';
  String salary = '';
  String jobType = '';
  String workspace = '';
  String q1 = '';
  String q2 = '';
  String q3 = '';
  String ex_from='';
  String ex_to='';

}
