import '../data/model/interview_model.dart';

abstract class InterviewState {}

class InterviewInitial extends InterviewState {}

class InterviewLoading extends InterviewState {}

class InterviewLoaded extends InterviewState {
  final List<InterviewModel> interviews;

  InterviewLoaded(this.interviews);
}

class InterviewError extends InterviewState {
  final String message;

  InterviewError(this.message);
}