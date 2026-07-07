class CurrentUserRank {
  final int rank;
  final double averageScore;
  final int highestScore;
  final double percentile;
  final bool isRanked;
  final int sessionsNeededToRank;

  const CurrentUserRank({
    required this.rank,
    required this.averageScore,
    required this.highestScore,
    required this.percentile,
    required this.isRanked,
    required this.sessionsNeededToRank,
  });

  factory CurrentUserRank.fromJson(Map<String, dynamic> json) {
    return CurrentUserRank(
      rank: json["rank"] ?? 0,
      averageScore:
      (json["averageScore"] as num?)?.toDouble() ?? 0,
      highestScore: json["highestScore"] ?? 0,
      percentile:
      (json["percentile"] as num?)?.toDouble() ?? 0,
      isRanked: json["isRanked"] ?? false,
      sessionsNeededToRank:
      json["sessionsNeededToRank"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "rank": rank,
      "averageScore": averageScore,
      "highestScore": highestScore,
      "percentile": percentile,
      "isRanked": isRanked,
      "sessionsNeededToRank": sessionsNeededToRank,
    };
  }

  CurrentUserRank copyWith({
    int? rank,
    double? averageScore,
    int? highestScore,
    double? percentile,
    bool? isRanked,
    int? sessionsNeededToRank,
  }) {
    return CurrentUserRank(
      rank: rank ?? this.rank,
      averageScore: averageScore ?? this.averageScore,
      highestScore: highestScore ?? this.highestScore,
      percentile: percentile ?? this.percentile,
      isRanked: isRanked ?? this.isRanked,
      sessionsNeededToRank:
      sessionsNeededToRank ?? this.sessionsNeededToRank,
    );
  }
}