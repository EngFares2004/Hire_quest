class LeaderboardUser {
  final int rank;
  final String userId;
  final String fullName;
  final String profilePictureUrl;
  final String userLevel;
  final double averageScore;
  final int highestScore;
  final int completedSessions;
  final int currentStreakDays;
  final bool isCurrentUser;

  const LeaderboardUser({
    required this.rank,
    required this.userId,
    required this.fullName,
    required this.profilePictureUrl,
    required this.userLevel,
    required this.averageScore,
    required this.highestScore,
    required this.completedSessions,
    required this.currentStreakDays,
    this.isCurrentUser = false,
  });

  factory LeaderboardUser.fromJson(
      Map<String, dynamic> json, {
        bool isCurrentUser = false,
      }) {
    String image = json["profilePictureUrl"] ?? "";

    if (image.isEmpty ||
        image == "string" ||
        image == "null") {
      image =
      "https://ui-avatars.com/api/?name=${Uri.encodeComponent(json["fullName"] ?? "")}&background=random&size=200&bold=true";
    } else if (!image.startsWith("http")) {
      image = "https://hirequest.runasp.net$image";
    }

    return LeaderboardUser(
      rank: json["rank"] ?? 0,
      userId: json["userId"] ?? "",
      fullName: json["fullName"] ?? "",
      profilePictureUrl: image,
      userLevel: json["userLevel"] ?? "",
      averageScore:
      (json["averageScore"] as num?)?.toDouble() ?? 0,
      highestScore: json["highestScore"] ?? 0,
      completedSessions: json["completedSessions"] ?? 0,
      currentStreakDays: json["currentStreakDays"] ?? 0,
      isCurrentUser: isCurrentUser,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "rank": rank,
      "userId": userId,
      "fullName": fullName,
      "profilePictureUrl": profilePictureUrl,
      "userLevel": userLevel,
      "averageScore": averageScore,
      "highestScore": highestScore,
      "completedSessions": completedSessions,
      "currentStreakDays": currentStreakDays,
      "isCurrentUser": isCurrentUser,
    };
  }

  LeaderboardUser copyWith({
    int? rank,
    String? userId,
    String? fullName,
    String? profilePictureUrl,
    String? userLevel,
    double? averageScore,
    int? highestScore,
    int? completedSessions,
    int? currentStreakDays,
    bool? isCurrentUser,
  }) {
    return LeaderboardUser(
      rank: rank ?? this.rank,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      profilePictureUrl:
      profilePictureUrl ?? this.profilePictureUrl,
      userLevel: userLevel ?? this.userLevel,
      averageScore: averageScore ?? this.averageScore,
      highestScore: highestScore ?? this.highestScore,
      completedSessions:
      completedSessions ?? this.completedSessions,
      currentStreakDays:
      currentStreakDays ?? this.currentStreakDays,
      isCurrentUser:
      isCurrentUser ?? this.isCurrentUser,
    );
  }

  String get scoreText =>
      averageScore.toStringAsFixed(1);

  String get highestScoreText =>
      "$highestScore pts";

  String get sessionsText =>
      "$completedSessions Sessions";

  String get streakText =>
      "$currentStreakDays Days";
}