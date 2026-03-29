import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

import '../../domain/entities/user_preferences.dart';
import '../../domain/repositories/onboarding_repository.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository repository;

  OnboardingCubit(this.repository) : super(const OnboardingState());

  /// ---------- PAGE CONTROLS ----------
  void setPage(int page) => emit(state.copyWith(page: page));
  void setDefinePathValid(bool value) => emit(state.copyWith(definePathValid: value));
  void setAtmosphereValid(bool value) => emit(state.copyWith(atmosphereValid: value));
  void setCustomizeValid(bool value) => emit(state.copyWith(customizeValid: value));

  void next() {
    if (!state.canContinue) return;
    if (state.page < 2) emit(state.copyWith(page: state.page + 1));
  }

  void back() {
    if (state.page > 0) emit(state.copyWith(page: state.page - 1));
  }

  /// ---------- SUBMIT ALL PREFERENCES ----------
  Future<void> submitAllPreferences({
    required String jobTitle,
    required String userLevel,
    required String environmentType,
    required String interviewerBehavior,
    required String interviewerGender,
    required String interviewLanguage,
  }) async {
    emit(state.copyWith(isSubmitting: true, error: null));

    try {
      final prefs = UserPreferences(
        jobTitle: jobTitle,
        userLevel: userLevel,
        environmentType: environmentType,
        interviewerPersonality: interviewerBehavior,
        interviewerGender: interviewerGender,
        interviewLanguage: interviewLanguage,
      );

      await repository.saveUserPreferences(prefs);

      emit(state.copyWith(isSubmitting: false, submitted: true));
    } catch (e) {
      dev.log('submitAllPreferences failed: $e');
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }
}
