import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/widgets/customer_sub_title.dart';
import 'package:hire_quest/features/interviews/ui/screens/report_screen.dart';

import '../../bloc/interview_cubit.dart';
import '../../bloc/interview_state.dart';
import '../../services/interview_services.dart';
import '../widgets/interview_card.dart';
import '../widgets/score_card.dart';

const List<String> interviewsScore = [
  'Total Interview',
  'Overall Score',
  'Highest Score',
];

class InterviewScreen extends StatelessWidget {
  const InterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InterviewCubit(InterviewService())..getInterviews(),
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

          if (state is InterviewLoaded) {
            final interviews = state.interviews;
            final hasData = interviews.isNotEmpty;

            /// ===================== DYNAMIC CALCULATION =====================
            final int totalInterviews = interviews.length;

            final double avgScore = hasData
                ? interviews
                .map((e) => e.score)
                .reduce((a, b) => a + b) /
                interviews.length
                : 0;

            final num highestScore = hasData
                ? interviews
                .map((e) => e.score)
                .reduce((a, b) => a > b ? a : b)
                : 0;

            return SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),

                    /// ================= SCORE SECTION =================
                    _ScoreSection(
                      isEmpty: !hasData,
                      totalScore: totalInterviews,
                      avgScore: avgScore,
                      highestScore: highestScore ,
                    ),

                    const SizedBox(height: 20),

                    const SubTitle(
                      title: 'Interview History',
                      spacebtw: 16,
                      space: 16,
                      size: 20,
                    ),

                    const SizedBox(height: 10),

                    hasData
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: interviews.length,
                      itemBuilder: (context, index) {
                        final interview = interviews[index];

                        return InterviewCardWidget(
                          title:
                          "${interview.trackName} • ${interview.difficulty}",
                          score: "Score: ${interview.score}/100",
                          subtitle: "${interview.createdAt}",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReportScreen(
                                  interviewId: interview.id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                        : const _EmptyState(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

/// ================= SCORE SECTION =================
class _ScoreSection extends StatelessWidget {
  final bool isEmpty;
  final int totalScore;
  final double avgScore;
  final num highestScore;

  const _ScoreSection({
    required this.isEmpty,
    required this.totalScore,
    required this.avgScore,
    required this.highestScore,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          ScoreCard(
            title: interviewsScore[0],
            value: isEmpty ? '_' : totalScore.toString(),
          ),
          const SizedBox(width: 12),
          ScoreCard(
            title: interviewsScore[1],
            value: isEmpty ? '_' : "${avgScore.toStringAsFixed(1)}/100",
          ),
          const SizedBox(width: 12),
          ScoreCard(
            title: interviewsScore[2],
            value: isEmpty ? '_' : "$highestScore/100",
          ),
        ],
      ),
    );
  }
}

/// ================= EMPTY STATE =================
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Center(
        child: Text(
          'Your session records will appear here.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}