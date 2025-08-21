class CandidateModel {
  final String id;
  final String name;
  final String jobTitle;
  final double rating;
  final String location;
  final String image;

  CandidateModel({
    required this.id,
    required this.name,
    required this.jobTitle,
    required this.rating,
    required this.location,
    required this.image,
  });

  factory CandidateModel.fromJson(Map<String, dynamic> json) => CandidateModel(
        id: json['id'],
        name: json['name'],
        jobTitle: json['jobTitle'],
        rating: (json['rating'] as num).toDouble(),
        location: json['location'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'jobTitle': jobTitle,
        'rating': rating,
        'location': location,
        'image': image,
      };
}
