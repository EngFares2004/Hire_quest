import '../../domain/entities/user_preferences.dart';

class UserPreferencesModel extends UserPreferences {
  const UserPreferencesModel({
    required super.jobTitle,
    required super.userLevel,
    required super.environmentType,
    required super.interviewerPersonality,
    required super.interviewerGender,
    required super.interviewLanguage,
  });

  factory UserPreferencesModel.fromEntity(UserPreferences entity) {
    return UserPreferencesModel(
      jobTitle: entity.jobTitle,
      userLevel: entity.userLevel,
      environmentType: entity.environmentType,
      interviewerPersonality: entity.interviewerPersonality,
      interviewerGender: entity.interviewerGender,
      interviewLanguage: entity.interviewLanguage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "jobTitle": jobTitle,
      "userLevel": userLevel,
      "environmentType": environmentType,
      "interviewerPersonality": interviewerPersonality,
      "interviewerGender": interviewerGender,
      "interviewLanguage": interviewLanguage,
    };
  }
}
