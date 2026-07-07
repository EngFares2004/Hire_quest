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

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token =
        SharedHandler.instance.getString(SharedKeys.token);

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },

      onError: (error, handler) async {
        // لو Unauthorized
        if (error.response?.statusCode == 401) {
          final success = await _refreshToken();

          if (success) {
            final newToken =
            SharedHandler.instance.getString(SharedKeys.token);

            // إعادة الطلب
            final requestOptions = error.requestOptions;

            requestOptions.headers['Authorization'] =
            'Bearer $newToken';

            final cloneResponse = await dio.fetch(requestOptions);
            return handler.resolve(cloneResponse);
          }
        }

        return handler.next(error);
      },
    ));
  }

  // 🔥 Refresh Token مرة واحدة فقط عند الحاجة
  Future<bool> _refreshToken() async {
    final token =
    SharedHandler.instance.getString(SharedKeys.token);
    final refreshToken =
    SharedHandler.instance.getString(SharedKeys.refreshToken);

    if (token == null || refreshToken == null) return false;

    try {
      final response = await Dio().post(
        AppEndPoint.refreshToken,
        data: {
          "token": token,
          "refreshToken": refreshToken,
        },
      );

      if (response.data['success'] == true) {
        final newToken = response.data['data']?['token'];
        final newRefreshToken =
        response.data['data']?['refreshToken'];

        if (newToken != null) {
          await SharedHandler.instance
              .setString(SharedKeys.token, newToken);
        }

        if (newRefreshToken != null) {
          await SharedHandler.instance
              .setString(SharedKeys.refreshToken, newRefreshToken);
        }

        print("✅ Token refreshed");
        return true;
      }
    } catch (e) {
      print("❌ Refresh failed: $e");
    }

    return false;
  }

  // ======== Requests (بسيطة دلوقتي 👇) ========

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return await dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await dio.put(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) async {
    return await dio.delete(path, data: data);
  }
}