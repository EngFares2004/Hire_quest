class InterviewModel {
  final String id;
  final String trackName;
  final String difficulty;
  final num score;
  final num numQ;
  final DateTime createdAt;

  InterviewModel({
    required this.id,
    required this.trackName,
    required this.difficulty,
    required this.score,
    required this.numQ,
    required this.createdAt,
  });

  factory InterviewModel.fromJson(Map<String, dynamic> json) {
    return InterviewModel(
      id: json['interviewRecordId'] ?? '',
      trackName: json['trackName'] ?? '',
      difficulty: json['difficulty'] ?? '',
      score: json['averageScore'] ?? 70,
      numQ: json['numQuestions'] ?? 5,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}