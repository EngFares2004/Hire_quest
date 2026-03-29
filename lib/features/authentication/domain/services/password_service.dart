import 'package:dio/dio.dart';
import '../../../../configuration/network/end_point.dart';
import '../../../../configuration/network/dio_client.dart';
import '../../../../configuration/shared_handler/shared_handler.dart';
import '../../../../configuration/shared_handler/shared_keys.dart';

class ResetPassService {
  final DioClient dioClient = DioClient();

  // ===================== RESET PASSWORD =====================
  Future<Response> resetPassword({

    required String newPassword,
  }) async {
    return await dioClient.post(
      AppEndPoint.resetPassword,
      data: {

        "newPassword": newPassword,

      },
    );
  }

  // ===================== REFRESH TOKEN =====================
  Future<Response> refreshToken() async {
    final token = SharedHandler.instance.getString(SharedKeys.token);
    final refreshToken = SharedHandler.instance.getString(SharedKeys.refreshToken);

    if (token == null || refreshToken == null) {
      throw Exception("No token or refresh token found");
    }

    return await dioClient.post(
      AppEndPoint.refreshToken,
      data: {
        "token": token,
        "refreshToken": refreshToken,
      },
    );
  }

  // ===================== REVOKE TOKEN =====================
  Future<Response> revokeToken() async {
    return await dioClient.post(AppEndPoint.revokeToken);
  }
}
