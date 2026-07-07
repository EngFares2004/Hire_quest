class InterviewDetailsModel {
  final int score;
  final int best;
  final int great;
  final int inaccurate;
  final int missed;
  final List<QuestionModel> questions;

  InterviewDetailsModel({
    required this.score,
    required this.best,
    required this.great,
    required this.inaccurate,
    required this.missed,
    required this.questions,
  });

  factory InterviewDetailsModel.fromJson(Map<String, dynamic> json) {
    return InterviewDetailsModel(
      score: json['score'] ?? 0,
      best: json['best'] ?? 0,
      great: json['great'] ?? 0,
      inaccurate: json['inaccurate'] ?? 0,
      missed: json['missed'] ?? 0,
      questions: (json['questions'] as List? ?? [])
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
    );
  }
}

class QuestionModel {
  final String question;
  final String answer;
  final int score;
  final String recommendation;

  QuestionModel({
    required this.question,
    required this.answer,
    required this.score,
    required this.recommendation,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      score: json['score'] ?? 0,
      recommendation: json['recommendation'] ?? '',
    );
  }
}