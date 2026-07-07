import '../../../account/domain/models/preferences_model.dart';
import '../../data/models/user_preferences_options_model.dart';
import '../entities/user_preferences.dart';

abstract class OnboardingRepository {
  Future<void> saveUserPreferences(UserPreferences prefs);
  Future<UserPreferencesOptionsModel> getOptions();
  Future<UserPreferencesModelEdit> getUserPreferences();
  Future<void> updateUserPreferences(
      UserPreferencesModelEdit model);
}
