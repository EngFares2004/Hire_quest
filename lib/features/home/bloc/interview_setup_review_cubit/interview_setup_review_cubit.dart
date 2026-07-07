import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/network/dio_client.dart';
import '../../../../configuration/network/end_point.dart';

import '../../data/models/interview_setup_review_model.dart';
import 'interview_setup_review_state.dart';

class InterviewSetupReviewCubit extends Cubit<InterviewSetupReviewState> {
  final DioClient dio;

  InterviewSetupReviewCubit(this.dio)
      : super(InterviewSetupReviewInitial());

  Future<void> loadUserSetup() async {
    emit(InterviewSetupReviewLoading());

    try {
      final response = await dio.get(
        AppEndPoint.myProfile,
        queryParameters: {
          'includePreferences': true,
          'includeStatistics': true,
        },
      );

      final model = InterviewSetupReviewModel.fromJson(response.data);

      emit(InterviewSetupReviewLoaded(model));
    } catch (e) {
      emit(InterviewSetupReviewError(e.toString()));
    }
  }
}