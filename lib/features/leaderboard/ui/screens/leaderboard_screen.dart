import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/theme/theme.dart';
import 'package:hire_quest/generated/assets.dart';

import '../cubit/leaderboard_cubit/leaderboard_cubit.dart';
import '../widgets/filter_overlay.dart';
import '../widgets/leaderboard_list_tile.dart';
import '../widgets/leaderboard_tab_bar.dart';
import '../widgets/top_three_podium.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LeaderboardCubit(),
      child: const _LeaderboardView(),
    );
  }
}

class _LeaderboardView extends StatelessWidget {
  const _LeaderboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //================ Header =================

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.selectedJobTitle,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primary,
                                ),
                              ),
                              Text(
                                state.selectedUserLevel ??
                                    "All Levels",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color:
                                  AppTheme.borderColor,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<LeaderboardCubit>()
                                  .toggleFilter();
                            },
                            child: Padding(
                              padding:
                              const EdgeInsets.all(8),
                              child: Assets.icons.filter
                                  .svg(
                                width: 32,
                                height: 32,
                                color: AppTheme.primary,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                //================ Tabs =================

                BlocBuilder<LeaderboardCubit,
                    LeaderboardState>(
                  builder: (context, state) {
                    return LeaderboardTabBar(
                      selected: state.selectedTab,
                      onTab: context
                          .read<LeaderboardCubit>()
                          .selectTab,
                    );
                  },
                ),

                const SizedBox(height: 8),

                //================ Top 3 =================

                BlocBuilder<LeaderboardCubit,
                    LeaderboardState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child:
                          CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (state.topThree.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return TopThreePodium(
                      topThree: state.topThree,
                    );
                  },
                ),

                const SizedBox(height: 12),

                //================ Table Header =================

                Container(
                  margin:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius:
                    BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(.05),
                        blurRadius: 6,
                        offset:
                        const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Text(
                        "Rank",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.w600,
                          color:
                          AppTheme.primary,
                        ),
                      ),
                      SizedBox(width: 40),
                      Expanded(
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.w600,
                            color:
                            AppTheme.primary,
                          ),
                        ),
                      ),
                      Text(
                        "Score",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.w600,
                          color:
                          AppTheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                //================ List =================

                Expanded(
                  child: BlocBuilder<
                      LeaderboardCubit,
                      LeaderboardState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                          child:
                          CircularProgressIndicator(),
                        );
                      }

                      if (state.restUsers
                          .isEmpty) {
                        return const Center(
                          child: Text(
                              "No Users",style: TextStyle(
                            fontSize: 20,
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold
                          ),


                          ),
                        );
                      }

                      return ListView.builder(
                        padding:
                        const EdgeInsets.only(
                            bottom: 12),
                        itemCount:
                        state.restUsers.length,
                        itemBuilder:
                            (context, index) {
                          return LeaderboardListTile(
                            user:
                            state.restUsers[index],
                          );
                        },
                      );
                    },
                  ),
                ),

                //================ Current User =================

                BlocBuilder<
                    LeaderboardCubit,
                    LeaderboardState>(
                  builder: (context, state) {
                    if (state.currentUserRank ==
                        null) {
                      return const SizedBox();
                    }

                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          leading: const CircleAvatar(
                            child:
                            Icon(Icons.person),
                          ),
                          title:  Text(
                              "(You)"),
                          subtitle: Text(
                            "Rank : ${state.currentUserRank!.rank + 1}",
                          ),
                          trailing: Text(
                            "${state.currentUserRank!
                                 .averageScore} %"
                               ,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const Positioned.fill(
            child: FilterOverlay(),
          ),
        ],
      ),
    );
  }
}