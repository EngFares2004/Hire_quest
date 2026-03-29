import 'package:dio/dio.dart';
import 'end_point.dart';
import '../shared_handler/shared_handler.dart';
import '../shared_handler/shared_keys.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppEndPoint.baseUrl,
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) => status != null && status < 500,
      ),
    );
  }

  // ======= تأكد من صلاحية التوكن قبل أي request =======
  Future<void> ensureTokenValid() async {
    final token = SharedHandler.instance.getString(SharedKeys.token);
    final refreshToken = SharedHandler.instance.getString(SharedKeys.refreshToken);

    // لو التوكن موجود بالفعل
    if (token == null || refreshToken == null) return;

    try {
      final response = await dio.post(
        AppEndPoint.refreshToken,
        data: {
          "token": token,
          "refreshToken": refreshToken,
        },
      );

      if (response.data['success'] == true) {
        final newToken = response.data['data']?['token'];
        final newRefreshToken = response.data['data']?['refreshToken'];

        if (newToken != null) {
          await SharedHandler.instance.setString(SharedKeys.token, newToken);
        }
        if (newRefreshToken != null) {
          await SharedHandler.instance.setString(SharedKeys.refreshToken, newRefreshToken);
        }
        print("✅ Token refreshed successfully");
      }
    } catch (e) {
      print("❌ Refresh token failed: $e");
    }
  }


  // ======== GET ========
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    await ensureTokenValid();
    final token = SharedHandler.instance.getString(SharedKeys.token);

    return await dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }

  // ======== POST ========
  Future<Response> post(String path, {dynamic data}) async {
    await ensureTokenValid();
    final token = SharedHandler.instance.getString(SharedKeys.token);

    return await dio.post(
      path,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }

  // ======== PUT ========
  Future<Response> put(String path, {dynamic data}) async {
    await ensureTokenValid();
    final token = SharedHandler.instance.getString(SharedKeys.token);

    return await dio.put(
      path,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }

  // ======== DELETE ========
  Future<Response> delete(String path, {dynamic data}) async {
    await ensureTokenValid();
    final token = SharedHandler.instance.getString(SharedKeys.token);

    return await dio.delete(
      path,
      data: data,
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }
}
