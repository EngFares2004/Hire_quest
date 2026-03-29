class HomeEntity {
  final bool hasInterview;
  final int questions;
  final int aiModels;
  final String duration;
  final int languages;
  final int total;
  final int average;
  final int best;
  final String level;
  final int recentScore;
  final String recentDuration;

 final String userName;

  final String role;

  final String? lastInterviewRole;
  final double? lastInterviewScore;
  final String? lastInterviewDate;

  HomeEntity({
    required this.userName,
    required this.role,
    required this.hasInterview,
    required this.questions,
    required this.aiModels,
    required this.duration,
    required this.languages,
    required this.total,
    required this.average,
    required this.best,
    required this.level,
    required this.recentScore,
    required this.recentDuration,
     this.lastInterviewRole,
     this.lastInterviewScore,
   this.lastInterviewDate,
  });
}
