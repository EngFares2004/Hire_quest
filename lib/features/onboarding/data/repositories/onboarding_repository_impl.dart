import 'package:hire_quest/features/account/domain/models/preferences_model.dart';

import '../../domain/entities/user_preferences.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_remote_datasource.dart';
import '../models/user_preferences_model.dart';
import '../models/user_preferences_options_model.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingRemoteDataSource remote;

  OnboardingRepositoryImpl(this.remote);

  @override
  Future<void> saveUserPreferences(UserPreferences preferences) async {
    final model = UserPreferencesModel.fromEntity(preferences);
    await remote.saveUserPreferences(model);
  }

  @override
  Future<UserPreferencesOptionsModel> getOptions() {
    return remote.getOptions();
  }

  @override
  Future<UserPreferencesModelEdit> getUserPreferences() {

    return remote.getUserPreferences();
  }
  @override
  Future<void> updateUserPreferences(
      UserPreferencesModelEdit model) {

    return remote.updateUserPreferences(model);
  }
}
