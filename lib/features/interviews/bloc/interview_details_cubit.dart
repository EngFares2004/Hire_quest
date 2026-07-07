import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/interview_details_model.dart';
import '../services/interview_details_service.dart';

/// ===== STATES =====
abstract class InterviewDetailsState {}

class DetailsLoading extends InterviewDetailsState {}

class DetailsLoaded extends InterviewDetailsState {
  final InterviewDetailsModel data;
  DetailsLoaded(this.data);
}

class DetailsError extends InterviewDetailsState {
  final String message;
  DetailsError(this.message);
}

/// ===== CUBIT =====
class InterviewDetailsCubit extends Cubit<InterviewDetailsState> {
  final InterviewDetailsService service;

  InterviewDetailsCubit(this.service) : super(DetailsLoading());

  Future<void> getDetails(String id) async {
    try {
      emit(DetailsLoading());

      final res = await service.getInterviewDetails(id);

      final data = InterviewDetailsModel.fromJson(res);

      emit(DetailsLoaded(data));
    } catch (e) {
      emit(DetailsError(e.toString()));
    }
  }
}