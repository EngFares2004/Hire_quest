class UserPreferencesOptionsModel {
  final List<String> jobTitles;
  final List<String> jobPaths;
  final List<String> userLevels;
  final List<String> environmentTypes;
  final List<String> interviewerPersonalities;
  final List<String> interviewerGenders;
  final List<String> interviewLanguages;

  UserPreferencesOptionsModel({
    required this.jobTitles,
    required this.jobPaths,
    required this.userLevels,
    required this.environmentTypes,
    required this.interviewerPersonalities,
    required this.interviewerGenders,
    required this.interviewLanguages,
  });

  factory UserPreferencesOptionsModel.fromJson(Map<String, dynamic> json) {
    List<String> mapList(dynamic list, List<String> fallback) {
      if (list == null || list is! List || list.isEmpty) {
        return fallback;
      }

      return list
          .map((e) => e is Map ? e['name'].toString() : e.toString())
          .toList();
    }

    return UserPreferencesOptionsModel(
      jobTitles: mapList(
        json['jobTitles'],
        ["Developer", "Designer", "QA", "Manager"],
      ),

      jobPaths: const [
        "Software Development",
        "UI/UX Design",
        "Data Science",
        "Cyber Security",
      ],

      userLevels: mapList(
        json['userLevel'],
        ["Entry", "Junior", "Semi-Junior", "Senior"],
      ),

      environmentTypes: mapList(
        json['environmentTypes'],
        ["Remote", "Onsite"],
      ),

      interviewerPersonalities: mapList(
        json['interviewerPersonalities'],
        ["Friendly", "Professional", "Challenger", "Busy Manager"],
      ),

      interviewerGenders: mapList(
        json['interviewerGenders'],
        ["Male", "Female"],
      ),

      interviewLanguages: mapList(
        json['interviewLanguages'],
        ["English", "Arabic"],
      ),
    );
  }
}
