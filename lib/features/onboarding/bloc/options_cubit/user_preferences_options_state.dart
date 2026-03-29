import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../../data/models/user_preferences_options_model.dart';

class OptionsState {
  final bool loading;
  final UserPreferencesOptionsModel? data;
  final String? error;

  const OptionsState({this.loading = false, this.data, this.error});
}
