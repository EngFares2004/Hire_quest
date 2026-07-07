import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../configuration/network/dio_client.dart';
import '../../../data/ repositories/leaderboard_repository.dart';
import '../../../data/model/current_user_rank..dart';
import '../../../data/model/leaderboard_user.dart';

part 'leaderboard_state.dart';

enum LeaderboardTab {
  daily,
  monthly,
  allTime,
}

class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit() : super(const LeaderboardState()) {
    loadJobTitles();
    loadLeaderboard();
  }

  final LeaderboardRepository _repository =
  LeaderboardRepository(DioClient());

  //================ Tabs =================

  void selectTab(LeaderboardTab tab) {
    emit(state.copyWith(selectedTab: tab));

    switch (tab) {
      case LeaderboardTab.daily:
        changePeriod("Weekly");
        break;

      case LeaderboardTab.monthly:
        changePeriod("Monthly");
        break;

      case LeaderboardTab.allTime:
        changePeriod("AllTime");
        break;
    }
  }

  //================ Filter =================

  void toggleFilter() {
    emit(
      state.copyWith(
        isFilterOpen: !state.isFilterOpen,
      ),
    );
  }

  void closeFilter() {
    emit(
      state.copyWith(
        isFilterOpen: false,
      ),
    );
  }

  //================ Filters =================

  void changeJobTitle(String value) {
    emit(
      state.copyWith(
        selectedJobTitle: value,
      ),
    );

    loadLeaderboard();
  }

  void changeUserLevel(String? value) {
    emit(
      state.copyWith(
        selectedUserLevel: value,
      ),
    );

    loadLeaderboard();
  }

  void changePeriod(String value) {
    emit(
      state.copyWith(
        selectedPeriod: value,
      ),
    );

    loadLeaderboard();
  }

  //================ Job Titles =================

  Future<void> loadJobTitles() async {
    try {
      final titles = await _repository.getJobTitles();

      emit(
        state.copyWith(
          jobTitles: titles,
          selectedJobTitle: titles.isNotEmpty
              ? titles.first
              : '',
        ),
      );

      await loadLeaderboard();
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
        ),
      );
    }
  }
  //================ Leaderboard =================

  Future<void> loadLeaderboard() async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
      ),
    );

    try {
      final response = await _repository.getLeaderboard(
        jobTitle: state.selectedJobTitle,
        userLevel: state.selectedUserLevel,
        period: state.selectedPeriod,
      );

      emit(
        state.copyWith(
          isLoading: false,
          users: response.users,
          currentUserRank: response.currentUserRank,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  //================ Refresh =================

  Future<void> refresh() async {
    await loadLeaderboard();
  }

  //================ Pagination =================

  Future<void> loadMore() async {}
}