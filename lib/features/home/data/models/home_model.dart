import '../../domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  HomeModel({
    required super.userName,
    required super.role,
    required super.hasInterview,
    required super.questions,
    required super.aiModels,
    required super.duration,
    required super.languages,
    required super.total,
    required super.average,
    required super.best,
    required super.level,
    required super.recentScore,
    required super.recentDuration,
    super.lastInterviewRole,
    super.lastInterviewScore,
    super.lastInterviewDate,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      userName: json['userName'] as String,
      role: json['role'] as String,
      hasInterview: json['hasInterview'] as bool,
      questions: json['questions'] as int,
      aiModels: json['aiModels'] as int,
      duration: json['duration'] as String,
      languages: json['languages'] as int,
      total: json['total'] as int,
      average: json['average'] as int,
      best: json['best'] as int,
      level: json['level'] as String,
      recentScore: json['recentScore'] as int,
      recentDuration: json['recentDuration'] as String,
      lastInterviewRole: json['lastInterviewRole'] as String?,
      lastInterviewScore: json['lastInterviewScore'] != null
          ? (json['lastInterviewScore'] as num).toDouble()
          : null,
      lastInterviewDate: json['lastInterviewDate'] as String?,
    );
  }
}
