

import '../../../../configuration/network/dio_client.dart';
import '../../../../configuration/network/end_point.dart';
import '../model/current_user_rank..dart';
import '../model/leaderboard_user.dart';

class LeaderboardResponse {
  final List<LeaderboardUser> users;
  final CurrentUserRank currentUserRank;
  final List<String> jobTitles;

  const LeaderboardResponse({
    required this.users,
    required this.currentUserRank,
    this.jobTitles = const [],
  });
}

class LeaderboardRepository {
  final DioClient dioClient;

  LeaderboardRepository(this.dioClient);

  Future<LeaderboardResponse> getLeaderboard({
    required String jobTitle,
    String? userLevel,
    required String period,
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await dioClient.get(
      AppEndPoint.leaderboard,
      queryParameters: {
        "JobTitle": jobTitle,
        "UserLevel": userLevel,
        "Period": period,
        "Page": page,
        "PageSize": pageSize,
      },
    );

    if (response.data["success"] != true) {
      throw Exception(response.data["message"]);
    }

    final data = response.data["data"];

    final users = (data["entries"] as List)
        .map((e) => LeaderboardUser.fromJson(e))
        .toList();

    final currentUser = CurrentUserRank.fromJson(
      data["currentUserRank"],
    );

    return LeaderboardResponse(
      users: users,
      currentUserRank: currentUser,
    );
  }

  Future<List<String>> getJobTitles() async {
    final response = await dioClient.get(
      AppEndPoint.leaderboardJobTitles,
    );
    if (response.data["success"] != true) {
      throw Exception(response.data["message"]);
    }

    return List<String>.from(response.data["data"]);
  }
}