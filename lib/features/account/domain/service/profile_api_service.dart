import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../configuration/network/end_point.dart';
import '../../../../configuration/network/dio_client.dart';

class ProfileApiService {
  final DioClient dioClient;

  ProfileApiService(this.dioClient);

  // ==================== GET MY PROFILE ====================
  Future<Response> getMyProfile({
    bool includePreferences = false,
    bool includeStatistics = false,
  }) async {
    try {
      final res = await dioClient.get(
        AppEndPoint.myProfile,
        queryParameters: {
          'includePreferences': includePreferences,
          'includeStatistics': includeStatistics,
        },
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // ==================== UPDATE PROFILE ====================
  Future<Response> updateProfile(Map<String, dynamic> body) async {
    try {
      final res = await dioClient.put(AppEndPoint.myProfile, data: body);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // ==================== UPLOAD AVATAR ====================
  Future<Response> uploadAvatar(File file) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });
      final res = await dioClient.post(AppEndPoint.uploadAvatar, data: formData);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  // ==================== DELETE AVATAR ====================
  Future<Response> deleteAvatar() async {
    try {
      final res = await dioClient.delete(AppEndPoint.deleteAvatar);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
