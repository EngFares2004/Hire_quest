part of 'interview_code_cubit.dart';

abstract class InterviewCodeState {}

class InterviewCodeInitial extends InterviewCodeState {}

class InterviewCodeLoading extends InterviewCodeState {}

class InterviewCodeGenerated extends InterviewCodeState {
  final String code;
  final int remainingSeconds;

  InterviewCodeGenerated(this.code, this.remainingSeconds);
}

class InterviewCodeExpired extends InterviewCodeState {}

class InterviewCodeError extends InterviewCodeState {
  final String message;

  InterviewCodeError(this.message);
}