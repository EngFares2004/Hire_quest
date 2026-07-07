import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/theme/theme.dart';
import 'package:hire_quest/configuration/widgets/customer_title.dart';

import '../../../../configuration/network/dio_client.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../../configuration/widgets/customer_sub_title.dart';
import '../../../../generated/assets.dart';
import '../../bloc/interview_setup_review_cubit/interview_setup_review_cubit.dart';
import '../../domain/entities/home_entity.dart';
import '../widgets/interview_review_bottomSheet.dart';
import '../widgets/stat_card.dart';
import '../widgets/stats_grid.dart';

class BeforeInterviewSection extends StatelessWidget {
  final HomeEntity data;
  const BeforeInterviewSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        //  HeaderSection(data: data),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(vertical: 20),

                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubTitle(
                        title: 'Your Progress Stats',
                        space: 0,
                        size: 20,
                      ),

                      StatsGrid(
                        items: [
                          StatCard(
                            icon: Assets.icons.monitor,
                            title: "Total Interviews",
                            value: '${data.total}',
                            color: AppTheme.babyBlue,
                          ),
                          StatCard(
                            icon: Assets.icons.favoriteChart,
                            title: "Average Score",
                            value: "${data.average}/100",
                            color: AppTheme.babyBlue,
                          ),
                          StatCard(
                            icon: Assets.icons.cup,
                            title: "Best Score",
                            value: "${data.best}/100",
                            color: AppTheme.green,
                          ),
                          StatCard(
                            icon: Assets.icons.level,
                            title: "Current Level",
                            value: data.level,
                            color: AppTheme.green,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomBottom(
                        title: 'Start New Interview',
                        textSize: 16,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            isScrollControlled: true,
                            builder: (_) => BlocProvider(
                              create: (_) =>
                                  InterviewSetupReviewCubit(DioClient())
                                    ..loadUserSetup(),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                child: const InterviewSetupReviewBottomSheet(),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: EdgeInsets.only(bottom: 20),

                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomerTitle(
                        title: 'Recent Activity',
                        desc: "${data.role} • ${data.level} Level",
                        sizeTitle: 20,
                        colorSubtitle: AppTheme.primary,
                      ),
                      SizedBox(height: 8),
                      CustomerTitle(
                        title: 'Score: ${data.recentScore}/100',
                        desc: "${data.recentDuration} ",
                        sizeTitle: 20,
                      ),

                      const SizedBox(height: 16),
                      CustomBottom(
                        title: 'View Details',
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            isScrollControlled: true,
                            builder: (_) => BlocProvider(
                              create: (_) =>
                                  InterviewSetupReviewCubit(DioClient())
                                    ..loadUserSetup(),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                child: const InterviewSetupReviewBottomSheet(),
                              ),
                            ),
                          );
                        },
                        isOutline: true,
                        textColor: AppTheme.primary,
                        textSize: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
