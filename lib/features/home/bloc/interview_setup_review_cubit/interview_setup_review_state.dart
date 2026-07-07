import '../../data/models/interview_setup_review_model.dart';

abstract class InterviewSetupReviewState {}

class InterviewSetupReviewInitial extends InterviewSetupReviewState {}

class InterviewSetupReviewLoading extends InterviewSetupReviewState {}

class InterviewSetupReviewLoaded extends InterviewSetupReviewState {
  final InterviewSetupReviewModel data;

  InterviewSetupReviewLoaded(this.data);
}

class InterviewSetupReviewError extends InterviewSetupReviewState {
  final String message;

  InterviewSetupReviewError(this.message);
}