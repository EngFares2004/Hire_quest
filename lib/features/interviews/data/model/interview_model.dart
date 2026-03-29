class InterviewModel {
  final String id;
  final String trackName;
  final int score;
  final DateTime createdAt;

  InterviewModel({
    required this.id,
    required this.trackName,
    required this.score,
    required this.createdAt,
  });

  factory InterviewModel.fromJson(Map<String, dynamic> json) {
    return InterviewModel(
      id: json['id'] ?? '',
      trackName: json['trackName'] ?? '',
      score: json['score'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}