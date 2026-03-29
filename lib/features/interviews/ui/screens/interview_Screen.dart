import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/widgets/customer_bottom.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';

import '../../../../configuration/theme/theme.dart';
import '../../bloc/interview_cubit.dart';
import '../../bloc/interview_state.dart';
import '../../services/interview_services.dart';

List<String> interviewsScore = [
  'Total Interview',
  'Overall Score',
  'Highest Score',
];

class InterviewScreen extends StatelessWidget {
  const InterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      InterviewCubit(InterviewService())..getInterviews(),
      child: const _InterviewView(),
    );
  }
}

class _InterviewView extends StatelessWidget {
  const _InterviewView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InterviewCubit, InterviewState>(
        builder: (context, state) {
          if (state is InterviewLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InterviewError) {
            return Center(child: Text(state.message));
          }

          if (state is InterviewLoaded && state.interviews.isEmpty) {
            return const _EmptyInterview();
          }

          if (state is InterviewLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  // 💡 Horizontal Score Cards
                  SizedBox(
                    height: 200, // ارتفاع ثابت لمنع overflow
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(16),
                      itemCount: interviewsScore.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: ScoreCard(
                            title: interviewsScore[index],
                            value: index == 0
                                ? '21'
                                : index == 1
                                ? '82/100'
                                : '91/100',
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 📄 Section Title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SubTitle(
                      title: 'Interview History',
                      spacebtw: 16,
                      space: 24,
                      size: 20,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 💡 Vertical List of Interviews
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    itemCount: state.interviews.length,
                    itemBuilder: (context, index) {
                      final interview = state.interviews[index];
                      return InterviewCardWidget(
                        title: "${interview.trackName} • Junior",
                        score: "Score: ${interview.score}/100",
                        subtitle: "2 days ago • 25 minutes",
                        onTap: () {},
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

// ==================== Widgets ====================

class ScoreCard extends StatelessWidget {
  final String title;
  final String value;

  const ScoreCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.borderColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubTitle(
            title: title,
            size: 14,
            spacebtw: 6,
            space: 0,
            colorTitle: AppTheme.primary,
          ),
          SubTitle(
            title: value,
            size: 16,
            spacebtw: 6,
            colorTitle: AppTheme.primary,
            space: 0,
          ),
        ],
      ),
    );
  }
}

class InterviewCardWidget extends StatelessWidget {
  final String title;
  final String score;
  final String subtitle;
  final VoidCallback? onTap;

  const InterviewCardWidget({
    super.key,
    required this.title,
    required this.score,
    this.subtitle = '',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.borderColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubTitle(
            title: title,
            size: 16,
            spacebtw: 6,
            space: 16,
            colorTitle: AppTheme.primary,
          ),
          SubTitle(
            title: score,
            size: 20,
            spacebtw: 6,
            colorTitle: AppTheme.primary,
            space: 0,
          ),
          if (subtitle.isNotEmpty)
            SubTitle(
              title: subtitle,
              size: 12,
              spacebtw: 16,
              colorTitle: AppTheme.grey,
              space: 0,
            ),
          if (onTap != null)
            CustomBottom(
              textSize: 14,
              textColor: AppTheme.primary,
              isOutline: true,
              title: 'View Report',
              onTap: onTap!,
            ),
        ],
      ),
    );
  }
}

// ==================== Empty State ====================

class _EmptyInterview extends StatelessWidget {
  const _EmptyInterview({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // مهم لمنع overflow
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),

          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              itemCount: interviewsScore.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: ScoreCard(title: interviewsScore[index], value: '_'),
                );
              },
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SubTitle(
              title: 'Interview History',
              spacebtw: 16,
              space: 24,
              size: 20,
            ),
          ),

          Center(
            child: SubTitle(
              title: 'Your session records will appear here.',
              isCenter: true,
              size: 16,
              spacebtw: 6,
              colorTitle: AppTheme.primary,
              space: 200,
            ),
          ),
        ],
      ),
    );
  }
}