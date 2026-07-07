import '../../../onboarding/domain/entities/user_preferences.dart';
class UserPreferencesModelEdit {

  final String jobTitle;
  final String userLevel;
  final String environmentType;
  final String interviewerPersonality;
  final String interviewerGender;
  final String interviewLanguage;

  UserPreferencesModelEdit({
    required this.jobTitle,
    required this.userLevel,
    required this.environmentType,
    required this.interviewerPersonality,
    required this.interviewerGender,
    required this.interviewLanguage,
  });

  // ================= FROM ENTITY =================

  factory UserPreferencesModelEdit.fromEntity(
      UserPreferences entity) {

    return UserPreferencesModelEdit(
      jobTitle: entity.jobTitle,
      userLevel: entity.userLevel,
      environmentType: entity.environmentType,
      interviewerPersonality:
      entity.interviewerPersonality,
      interviewerGender:
      entity.interviewerGender,
      interviewLanguage:
      entity.interviewLanguage,
    );
  }

  // ================= FROM JSON =================

  factory UserPreferencesModelEdit.fromJson(
      Map<String, dynamic> json) {

    return UserPreferencesModelEdit(
      jobTitle: json['jobTitle'] ?? '',
      userLevel: json['userLevel'] ?? '',
      environmentType:
      json['environmentType'] ?? '',
      interviewerPersonality:
      json['interviewerPersonality'] ?? '',
      interviewerGender:
      json['interviewerGender'] ?? '',
      interviewLanguage:
      json['interviewLanguage'] ?? '',
    );
  }

  // ================= TO JSON =================

  Map<String, dynamic> toJson() {
    return {
      "jobTitle": jobTitle,
      "userLevel": userLevel,
      "environmentType": environmentType,
      "interviewerPersonality":
      interviewerPersonality,
      "interviewerGender":
      interviewerGender,
      "interviewLanguage":
      interviewLanguage,
    };
  }
}
/*class UserPreferencesModel {
  final int? userPreferencesId;
  final String? userId;

  final String jobTitle;
  final String userLevel;
  final String environmentType;

  final String interviewerPersonality;
  final String interviewerGender;
  final String interviewLanguage;

  final int graduationYear;
  final int yearsOfExperience;

  UserPreferencesModel({
    this.userPreferencesId,
    this.userId,
    required this.jobTitle,
    required this.userLevel,
    required this.environmentType,
    required this.interviewerPersonality,
    required this.interviewerGender,
    required this.interviewLanguage,
    required this.graduationYear,
    required this.yearsOfExperience,
  });

  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) {
    return UserPreferencesModel(
      userPreferencesId: json['userPreferencesId'],
      userId: json['userId'],
      jobTitle: json['jobTitle'],
      userLevel: json['userLevel'],
      environmentType: json['environmentType'],
      interviewerPersonality: json['interviewerPersonality'],
      interviewerGender: json['interviewerGender'],
      interviewLanguage: json['interviewLanguage'],
      graduationYear: json['graduationYear'],
      yearsOfExperience: json['yearsOfExperience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userPreferencesId": userPreferencesId,
      "userId": userId,
      "jobTitle": jobTitle,
      "userLevel": userLevel,
      "environmentType": environmentType,
      "interviewerPersonality": interviewerPersonality,
      "interviewerGender": interviewerGender,
      "interviewLanguage": interviewLanguage,
      "graduationYear": graduationYear,
      "yearsOfExperience": yearsOfExperience,
    };
  }
}*/