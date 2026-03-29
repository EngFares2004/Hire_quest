class UserPreferencesModel {
  final String jobTitle;
  final String userLevel;
  final String environmentType;
  final String interviewLanguage;

  UserPreferencesModel({
    required this.jobTitle,
    required this.userLevel,
    required this.environmentType,
    required this.interviewLanguage,
  });

  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) {
    return UserPreferencesModel(
      jobTitle: json['jobTitle'],
      userLevel: json['userLevel'],
      environmentType: json['environmentType'],
      interviewLanguage: json['interviewLanguage'],
    );
  }
}
