import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/theme/theme.dart';
import '../../../../configuration/widgets/customer_arrow_back.dart';
import '../../data/model/interview_details_model.dart';

class ReviewScreen extends StatelessWidget {
  final InterviewDetailsModel data;

  const ReviewScreen({super.key, required this.data});

  Color _getScoreColor(double score) {
    if (score >= 8) return Colors.green;
    if (score >= 5) return Colors.orange;
    return Colors.red;
  }

  String _getStatus(double score) {
    if (score >= 8) return "Best";
    if (score >= 5) return "Inaccurate";
    return "Weak";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isDark = theme.brightness == Brightness.dark;

    final primaryTextColor =
    isDark ? AppTheme.borderColor : AppTheme.black;

    final secondaryTextColor =
    isDark ? Colors.white70 : AppTheme.primary;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 32),
            child: CustomerArrowBack(
              title: "Questions Deep Dive",
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.2,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: data.questions.length,
              itemBuilder: (context, index) {
                final q = data.questions[index];
                final scoreColor = _getScoreColor(q.score.toDouble());

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// QUESTION TITLE
                      Text(
                        "Q${index + 1}: ${q.question}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// ANSWER TITLE
                      Text(
                        "Your Answer",
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// ANSWER TEXT
                      Text(
                        q.answer,
                        style: TextStyle(
                          color: secondaryTextColor,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// SCORE BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: scoreColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Score ${q.score * 10}%  ${_getStatus(q.score.toDouble())}",
                          style: TextStyle(
                            color: scoreColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// AI RECOMMENDATION BOX
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.blueGrey.shade900
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isDark
                                ? Colors.blueGrey
                                : Colors.blue.shade100,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.smart_toy_outlined,
                              color: AppTheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                q.recommendation,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : AppTheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}