import 'package:dio/dio.dart';
import '../../../../configuration/network/dio_client.dart';
import '../../../../configuration/network/end_point.dart';

class UserPreferencesApiService {
  final DioClient dioClient;

  UserPreferencesApiService(this.dioClient);

  // ==================== GET USER PREFERENCES ====================
  Future<Response> getUserPreferences() async {
    try {
      return await dioClient.get(AppEndPoint.userPreferences);
    } catch (e) {
      rethrow;
    }
  }

  // ==================== CREATE OR UPDATE USER PREFERENCES ====================
  Future<Response> saveUserPreferences(Map<String, dynamic> body) async {
    try {
      return await dioClient.post(AppEndPoint.userPreferences, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserPreferences(Map<String, dynamic> body) async {
    try {
      return await dioClient.put(AppEndPoint.userPreferences, data: body);
    } catch (e) {
      rethrow;
    }
  }

  // ==================== GET OPTIONS ====================
  Future<Response> getUserPreferencesOptions() async {
    try {
      return await dioClient.get(AppEndPoint.userPreferencesOptions);
    } catch (e) {
      rethrow;
    }
  }
}