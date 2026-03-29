class InterviewSetupModel {
  final String environment;
  final String gender;
  final String language;
  final String persona;
  final double duration;
  final String level;
  final String path;
  final String role;

  InterviewSetupModel({
    required this.environment,
    required this.gender,
    required this.language,
    required this.persona,
    required this.duration,
    required this.level,
    required this.path,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'environment': environment,
      'gender': gender,
      'language': language,
      'persona': persona,
      'duration': duration,
      'level': level,
      'path': path,
      'role': role,
    };
  }

  factory InterviewSetupModel.fromJson(Map<String, dynamic> json) {
    return InterviewSetupModel(
      environment: json['environment'] ?? '',
      gender: json['gender'] ?? '',
      language: json['language'] ?? '',
      persona: json['persona'] ?? '',
      duration: (json['duration'] ?? 0).toDouble(),
      level: json['level'] ?? '',
      path: json['path'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
