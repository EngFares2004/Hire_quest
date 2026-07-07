import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_quest/configuration/theme/theme.dart';
import 'package:hire_quest/generated/assets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../configuration/widgets/customer_bottom.dart';
import '../../bloc/interview_details_cubit.dart';
import '../../services/interview_details_service.dart';
import 'review_screen.dart';

class ReportScreen extends StatelessWidget {
  final String interviewId;

  const ReportScreen({super.key, required this.interviewId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(

      create: (_) =>
      InterviewDetailsCubit(InterviewDetailsService())
        ..getDetails(interviewId),
      child: Scaffold(
        body: BlocBuilder<InterviewDetailsCubit, InterviewDetailsState>(
            builder: (context, state) {

              /// 🔄 Loading
              if (state is DetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              /// ❌ Error
              if (state is DetailsError) {
                return Center(child: Text(state.message));
              }

              /// ✅ Loaded
              if (state is DetailsLoaded) {
                final data = state.data;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 64),
                  child: TweenAnimationBuilder(
                    tween: Tween<Offset>(
                        begin: const Offset(0, 0.2), end: Offset.zero),
                    duration: const Duration(milliseconds: 600),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value.dy * 100),
                        child: Opacity(
                          opacity: 1 - value.dy,
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      children: [

                        const SizedBox(height: 20),

                        /// 🔵 Circle Score + Animation
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 4.7 / 100),
                          duration: const Duration(seconds: 1),
                          builder: (context, value, _) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularPercentIndicator(
                                  radius: 85,
                                  lineWidth: 12,
                                  percent: value,
                                  backgroundColor:AppTheme.borderColor ,
                                  progressColor:AppTheme.primary,
                                  circularStrokeCap:
                                  CircularStrokeCap.round,
                                ),
                                Text(
                                  "${(value * 100).toInt()}%",
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        Text(
                          _getPerformanceText(data.score),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.primary,
                          ),
                        ),

                        const SizedBox(height: 15),

                        /// 📌 Info Chips
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: [
                            _infoChip("Interview: Professional",context),
                            _infoChip("Questions: ${data.questions }",context),
                            _infoChip("Mode: Technical",context),
                            _infoChip("Time: 25 minutes",context),
                          ],
                        ),

                        const SizedBox(height: 25),

                        /// 📊 Stats Card
                        Container(
                          padding:
                          const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color:theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              _statItem(
                                icon: Assets.icons.star,
                                color: Colors.blue,
                                title: "Great",
                                value: data.great,
                              ),
                              _statItem(
                                icon:Assets.icons.cup,
                                color: Colors.green,
                                title: "Best",
                                value: data.best,
                              ),
                              _statItem(
                                icon: Assets.icons.infoCircle,
                                color: Colors.orange,
                                title: "Inaccurate",
                                value: data.inaccurate,
                              ),
                              _statItem(
                                icon: Assets.icons.missed,
                                color: Colors.red,
                                title: "Missed",
                                value: data.missed,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),
                        CustomBottom(
                          title: 'Review Questions ',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ReviewScreen(data: data),
                              ),
                            );

                          },
                          textSize: 16,

                        ),
                        /// 🚀 Button


                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
    );
  }

  /// 📌 Info Chip
  Widget _infoChip(String text,BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color:theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  /// 📊 Stat Item
  Widget _statItem({
    required SvgGenImage icon,
    required Color color,
    required String title,
    required int value,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: color.withOpacity(0.15),
          child: icon.svg(
            color: color
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// 🧠 Dynamic Text
  String _getPerformanceText(int score) {
    if (score >= 90) return "Excellent Performance! 🔥";
    if (score >= 75) return "Great Job! 💪";
    if (score >= 60) return "Solid Performance 👍";
    if (score >= 40) return "Keep Practicing 👀";
    return "Needs Improvement ❗";
  }
}