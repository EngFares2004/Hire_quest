class UserStatisticsModel {
  final int totalSessions;
  final int completedSessions;
  final double averageScore;

  UserStatisticsModel({
    required this.totalSessions,
    required this.completedSessions,
    required this.averageScore,
  });

  factory UserStatisticsModel.fromJson(Map<String, dynamic> json) {
    return UserStatisticsModel(
      totalSessions: json['totalSessions'],
      completedSessions: json['completedSessions'],
      averageScore: (json['averageScore'] as num).toDouble(),
    );
  }
}
