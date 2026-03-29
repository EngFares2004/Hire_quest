
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/onboarding_repository.dart';
import 'user_preferences_options_state.dart';

class OptionsCubit extends Cubit<OptionsState> {
  final OnboardingRepository repo;

  OptionsCubit(this.repo) : super(OptionsState());

  Future<void> loadOptions() async {
    emit(OptionsState(loading: true));
    try {
      final data = await repo.getOptions();
      emit(OptionsState(data: data));
    } catch (e) {
      emit(OptionsState(error: e.toString()));
    }
  }
}
