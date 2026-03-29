import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/theme/theme.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import 'package:hire_quest/configuration/widgets/customer_title.dart';

import '../../../../configuration/route/route.dart';
import '../../../../configuration/widgets/customer_bottom.dart';
import '../../../../generated/assets.dart';
import '../../../account/ui/cubit/default_iv_setting_cubit/default_iv_setting_cubit.dart';
import '../../../account/ui/widgets/career_configuration_btn_sheet.dart';
import '../../../onboarding/domain/repositories/onboarding_repository.dart';
import '../../domain/entities/home_entity.dart';
import '../widgets/header_section.dart';
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
        HeaderSection(data: data),
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
                      // SubTitle(title: 'Your Progress Stats'),
                      Text(
                        'Your Progress Stats',
                        style: const TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),

                      StatsGrid(
                        items: [
                          StatCard(
                            icon: Assets.iconsMonitor,
                            title: "Total Interviews",
                            value: '${data.total}',
                            color: AppTheme.babyBlue,
                          ),
                          StatCard(
                            icon: Assets.iconsFavoriteChart,
                            title: "Average Score",
                            value: "${data.average}/100",
                            color: AppTheme.babyBlue,
                          ),
                          StatCard(
                            icon: Assets.iconsCup,
                            title: "Best Score",
                            value: "${data.best}/100",
                            color: AppTheme.green,
                          ),
                          StatCard(
                            icon: Assets.iconsLevel,
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
                              create: (context) => DefaultIVSettingCubit(
                                context.read<OnboardingRepository>(),
                              )..loadOptions(),
                              child: SizedBox(
                                height:
                                MediaQuery.of(context).size.height *
                                    0.55,
                                child:
                                const InterviewSetupReviewBottomSheet(),
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
                              create: (context) => DefaultIVSettingCubit(
                                context.read<OnboardingRepository>(),
                              )..loadOptions(),
                              child: SizedBox(
                                height:
                                MediaQuery.of(context).size.height *
                                    0.55,
                                child:
                                const InterviewSetupReviewBottomSheet(),
                              ),
                            ),
                          );
                        },
                        isOutline: true,
                        textColor: AppTheme.primary,
                        textSize: 16,
                      )
                      ,
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
