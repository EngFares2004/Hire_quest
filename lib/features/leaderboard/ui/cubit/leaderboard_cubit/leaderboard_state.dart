part of 'leaderboard_cubit.dart';

class LeaderboardState {
  final bool isLoading;
  final bool isFilterOpen;

  final List<LeaderboardUser> users;
  final CurrentUserRank? currentUserRank;

  final List<String> jobTitles;

  final String selectedJobTitle;
  final String selectedPeriod;
  final String? selectedUserLevel;

  final LeaderboardTab selectedTab;

  final String? errorMessage;

  const LeaderboardState({
    this.isLoading = false,
    this.isFilterOpen = false,
    this.users = const [],
    this.currentUserRank,
    this.jobTitles = const [],
    this.selectedJobTitle = "BackendDeveloper",
    this.selectedPeriod = "AllTime",
    this.selectedUserLevel,
    this.selectedTab = LeaderboardTab.allTime,
    this.errorMessage,
  });

  LeaderboardState copyWith({
    bool? isLoading,
    bool? isFilterOpen,
    List<LeaderboardUser>? users,
    CurrentUserRank? currentUserRank,
    List<String>? jobTitles,
    String? selectedJobTitle,
    String? selectedPeriod,
    String? selectedUserLevel,
    LeaderboardTab? selectedTab,
    String? errorMessage,
  }) {
    return LeaderboardState(
      isLoading: isLoading ?? this.isLoading,
      isFilterOpen: isFilterOpen ?? this.isFilterOpen,
      users: users ?? this.users,
      currentUserRank: currentUserRank ?? this.currentUserRank,
      jobTitles: jobTitles ?? this.jobTitles,
      selectedJobTitle: selectedJobTitle ?? this.selectedJobTitle,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      selectedUserLevel: selectedUserLevel ?? this.selectedUserLevel,
      selectedTab: selectedTab ?? this.selectedTab,
      errorMessage: errorMessage,
    );
  }

  List<LeaderboardUser> get topThree {
    final list = users.where((e) => e.rank <= 3).toList();
    list.sort((a, b) => a.rank.compareTo(b.rank));
    return list;
  }

  List<LeaderboardUser> get restUsers {
    final list = users.where((e) => e.rank > 3).toList();
    list.sort((a, b) => a.rank.compareTo(b.rank));
    return list;
  }

  bool get hasError =>
      errorMessage != null && errorMessage!.isNotEmpty;

  bool get hasUsers => users.isNotEmpty;

  bool get isEmpty =>
      !isLoading &&
          users.isEmpty &&
          !hasError;
}