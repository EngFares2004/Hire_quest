class HomeEntity {
  final String userName;
  final String role;
  final String level;

  final bool hasInterview;

  final int questions;
  final int aiModels;
  final String duration;
  final int languages;

  final int total;
  final dynamic average;
  final dynamic best;

  final dynamic recentScore;
  final String recentDuration;

  HomeEntity({
    required this.userName,
    required this.role,
    required this.level,
    required this.hasInterview,
    required this.questions,
    required this.aiModels,
    required this.duration,
    required this.languages,
    required this.total,
    required this.average,
    required this.best,
    required this.recentScore,
    required this.recentDuration,
  });
}