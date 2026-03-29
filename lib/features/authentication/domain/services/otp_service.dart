// otp_service.dart
import 'package:dio/dio.dart';
import '../../../../configuration/network/end_point.dart';

class OtpService {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );

  // Verify OTP
  Future<Response> verifyOtp({
    required String email,
    required String otpCode,
  }) async {
    return await dio.post(
      AppEndPoint.verifyOtp,
      data: {
        "email": email,
        "otpCode": otpCode,
      },
    );
  }

  // Resend OTP
  Future<Response> resendOtp({
    required String email,
  }) async {
    return await dio.post(
      AppEndPoint.resendOtp,
      data: {
        "email": email,
      },
    );
  }
}
