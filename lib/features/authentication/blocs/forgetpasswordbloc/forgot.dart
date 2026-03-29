import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetBloc extends Bloc<ForgetEvent, ForgetState> {
  ForgetBloc() : super(ForgetInitial()) {
    on<SendForgetRequest>(_onForget);
  }

  TextEditingController emailController = TextEditingController();

  Future<void> _onForget(
      SendForgetRequest event, Emitter<ForgetState> emit) async {
    emit(ForgetLoading());

    try {
      await Future.delayed(Duration(seconds: 3));
      emit(ForgetSuccess("Email sent successfully"));
    } catch (e) {
      emit(ForgetError("Failed to send email"));
    }
  }
}
abstract class ForgetEvent {}

class SendForgetRequest extends ForgetEvent {
  final String email;

  SendForgetRequest(this.email);
}
abstract class ForgetState {}

class ForgetInitial extends ForgetState {}

class ForgetLoading extends ForgetState {}

class ForgetSuccess extends ForgetState {
  final String message;
  ForgetSuccess(this.message);
}

class ForgetError extends ForgetState {
  final String message;
  ForgetError(this.message);
}
