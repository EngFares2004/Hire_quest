import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/interview_services.dart';
import 'interview_state.dart';

class InterviewCubit extends Cubit<InterviewState> {

  final InterviewService service;

  InterviewCubit(this.service) : super(InterviewInitial());

  Future<void> getInterviews() async {

    emit(InterviewLoading());

    try {

      final data = await service.getMyInterviews();

      emit(InterviewLoaded(data));

    } catch (e) {

      emit(InterviewError(e.toString()));

    }
  }
}