import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/route/route.dart';
import 'package:hire_quest/configuration/theme/theme.dart';
import 'package:hire_quest/configuration/widgets/customer_bottom.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import 'package:hire_quest/configuration/widgets/customer_title.dart';
import 'package:hire_quest/generated/assets.dart';
import '../../../account/ui/cubit/default_iv_setting_cubit/default_iv_setting_cubit.dart';
import '../../../onboarding/domain/repositories/onboarding_repository.dart';
import '../../domain/entities/home_entity.dart';
import '../widgets/header_section.dart';
import '../widgets/interview_review_bottomSheet.dart';
import '../widgets/stat_card.dart';
import '../widgets/stats_grid.dart';

class AfterInterviewSection extends StatelessWidget {
  final HomeEntity data;
  const AfterInterviewSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        HeaderSection(data: data),

        SizedBox(
          height: MediaQuery.of(context).size.height/1.3,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface, // Theme Aware
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Your Interview Today',
                        style: TextStyle(
                          color: AppTheme.primary, // Theme Aware
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      StatsGrid(
                        items: [
                          StatCard(
                            icon: Assets.iconsMessageQuestion,
                            title: 'Questions Available',
                            value: '+${data.questions}',
                            color: AppTheme.babyBlue,                  ),
                          StatCard(
                            icon: Assets.iconsAIModel,
                            title: 'AI Types Available',
                            value: '${data.aiModels} Models',
                            color: AppTheme.babyBlue,                  ),
                          StatCard(
                            icon: Assets.iconsClock,
                            title: 'Duration Per Test',
                            value: data.duration,
                            color: AppTheme.green,
                          ),
                          StatCard(
                            icon: Assets.iconsLanguage,
                            title: 'Languages Supported',
                            value: '${data.languages} Options',
                            color: AppTheme.green,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomBottom(
                        title: 'Start New Interview',
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
                        textSize: 16,

                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                Container(
                  width:double.infinity ,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface, // Theme Aware
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomerTitle(
                        title: 'Recent Activity',
                        desc: 'No interviews yet.',
                        sizeTitle: 20,
                        descSize: 16,
                      ),
                      Text(
                        'Your first interview is just one click away. '
                            '\nLet\'s build your confidence!',
                        style: TextStyle(
                            color: AppTheme.secondary, fontSize: 16),
                      ),
                      const SizedBox(height: 16),

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
