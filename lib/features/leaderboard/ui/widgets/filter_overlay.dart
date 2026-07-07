import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/theme/theme.dart';

import '../cubit/leaderboard_cubit/leaderboard_cubit.dart';

class FilterOverlay extends StatelessWidget {
  const FilterOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        if (!state.isFilterOpen) {
          return const SizedBox.shrink();
        }

        final isDark =
            Theme.of(context).brightness == Brightness.dark;

        final backgroundColor =
        isDark ? const Color(0xff1E1E1E) : AppTheme.white;

        final textColor =
        isDark ? AppTheme.white : Colors.black87;

        final fieldColor =
        isDark ? const Color(0xff2C2C2E) : AppTheme.white;

        final borderColor =
        isDark ? Colors.grey.shade700 : Colors.grey.shade300;

        return GestureDetector(
          onTap: () {
            context.read<LeaderboardCubit>().closeFilter();
          },
          child: Container(
            color: Colors.black54,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          "Filter Leaderboard",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      ///================ Job Title =================

                      Text(
                        "Job Title",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        isExpanded: true,

                        value: state.jobTitles.contains(
                            state.selectedJobTitle)
                            ? state.selectedJobTitle
                            : null,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fieldColor,

                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),

                          enabledBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: borderColor,
                            ),
                          ),

                          focusedBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                            borderSide:
                             BorderSide(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),

                        dropdownColor: backgroundColor,

                        hint: Text(
                        state.selectedJobTitle??'',
                          style:
                          TextStyle(color: textColor),
                        ),

                        items: state.jobTitles
                            .map(
                              (title) =>
                              DropdownMenuItem(
                                value: title,
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    color: textColor,
                                  ),
                                ),
                              ),
                        )
                            .toList(),

                        onChanged: (value) {
                          if (value != null) {
                            context
                                .read<
                                LeaderboardCubit>()
                                .changeJobTitle(
                                value);
                          }
                        },
                      ),

                      const SizedBox(height: 20),

                      ///================ User Level =================

                      Text(
                        "User Level",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String?>(
                        isExpanded: true,

                        value:
                        state.selectedUserLevel,

                        dropdownColor: backgroundColor,

                        decoration: InputDecoration(
                          filled: true,
                          fillColor: fieldColor,

                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),

                          enabledBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: borderColor,
                            ),
                          ),

                          focusedBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                            borderSide:
                             BorderSide(
                              color:AppTheme.primary,
                            ),
                          ),
                        ),

                        items: [
                          DropdownMenuItem<String?>(
                            value: null,
                            child: Text(
                              "All",
                              style: TextStyle(
                                  color: textColor),
                            ),
                          ),

                          ...[
                            "Beginner",
                            "Junior",
                            "MidLevel",
                            "Senior"
                          ].map(
                                (e) =>
                                DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      color: textColor,
                                    ),
                                  ),
                                ),
                          ),
                        ],

                        onChanged: (value) {
                          context
                              .read<
                              LeaderboardCubit>()
                              .changeUserLevel(
                              value);
                        },
                      ),

                      const SizedBox(height: 30),

                      ///================ Apply =================

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style:
                          ElevatedButton.styleFrom(
                            padding:
                            const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  12),
                            ),
                          ),
                          onPressed: () async {
                            await context
                                .read<
                                LeaderboardCubit>()
                                .loadLeaderboard();

                            if (context.mounted) {
                              context
                                  .read<
                                  LeaderboardCubit>()
                                  .closeFilter();
                            }
                          },
                          child: const Text(
                            "Apply",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      ///================ Cancel =================

                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            context
                                .read<
                                LeaderboardCubit>()
                                .closeFilter();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: isDark
                                  ? Colors.white70
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}