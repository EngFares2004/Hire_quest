class InterviewSetupReviewModel {
  final String jobTitle;
  final String userLevel;
  final String environmentType;
  final String interviewerPersonality;
  final String interviewerGender;
  final String interviewLanguage;
  final int yearsOfExperience;

  InterviewSetupReviewModel({
    required this.jobTitle,
    required this.userLevel,
    required this.environmentType,
    required this.interviewerPersonality,
    required this.interviewerGender,
    required this.interviewLanguage,
    required this.yearsOfExperience,
  });

  factory InterviewSetupReviewModel.fromJson(Map<String, dynamic> json) {
    final data = json['data']['preferences'];

    return InterviewSetupReviewModel(
      jobTitle: data['jobTitle'] ?? '',
      userLevel: data['userLevel'] ?? '',
      environmentType: data['environmentType'] ?? '',
      interviewerPersonality: data['interviewerPersonality'] ?? '',
      interviewerGender: data['interviewerGender'] ?? '',
      interviewLanguage: data['interviewLanguage'] ?? '',
      yearsOfExperience: data['yearsOfExperience'] ?? 0,
    );
  }
}