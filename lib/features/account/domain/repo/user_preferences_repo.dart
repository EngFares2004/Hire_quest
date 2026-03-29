import '../service/interview_api_service.dart';

class UserPreferencesRepository {
  final UserPreferencesApiService apiService;

  UserPreferencesRepository(this.apiService);

  Future<Map<String, dynamic>> getPreferences() async {
    final res = await apiService.getUserPreferences();
    return res.data;
  }

  Future<Map<String, dynamic>> savePreferences(Map<String, dynamic> data) async {
    final res = await apiService.saveUserPreferences(data);
    return res.data;
  }

  Future<Map<String, dynamic>> updatePreferences(Map<String, dynamic> data) async {
    final res = await apiService.updateUserPreferences(data);
    return res.data;
  }

  Future<Map<String, dynamic>> getOptions() async {
    final res = await apiService.getUserPreferencesOptions();
    return res.data;
  }
}