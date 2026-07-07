import 'package:flutter/foundation.dart';

import '../../domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  HomeModel({
    required super.userName,
    required super.role,
    required super.level,
    required super.hasInterview,
    required super.questions,
    required super.aiModels,
    required super.duration,
    required super.languages,
    required super.total,
    required super.average,
    required super.best,
    required super.recentScore,
    required super.recentDuration,
  });

  factory HomeModel.fromApi(Map<String, dynamic> json) {
    debugPrint('========== Home API Response ==========');
    debugPrint(json.toString());
    final stats = json['statistics'];
    final pref = json['preferences'];


    debugPrint('Preferences: $pref');
    debugPrint('Statistics: $stats');

    final model = HomeModel(
      userName: json['firstName'] ?? "User",
      role: pref?['jobTitle'] ?? "Developer",
      level: pref?['userLevel'] ?? "Junior",

      hasInterview: (stats?['totalSessions'] ?? 0) > 0,

      questions: 50,
      aiModels: 4,
      duration: "20-30 Minutes",
      languages: 2,

      total: stats?['totalSessions'] ?? 0,
      average: stats?['averageScore'] ?? 0,
      best: stats?['highestScore'] ?? 0,

      recentScore: stats?['averageScore'] ?? 0,
      recentDuration: "Last session recently",
    );

    debugPrint('========== Home Model ==========');
    debugPrint('userName: ${model.userName}');
    debugPrint('role: ${model.role}');
    debugPrint('level: ${model.level}');
    debugPrint('hasInterview: ${model.hasInterview}');
    debugPrint('total: ${model.total}');
    debugPrint('average: ${model.average}');
    debugPrint('best: ${model.best}');
    debugPrint('recentScore: ${model.recentScore}');
    debugPrint('================================');

    return model;
  }
}