import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../domain/services/otp_service.dart';
import '../../../../configuration/shared_handler/shared_handler.dart';
import 'otp_state.dart';
import '../../../../configuration/shared_handler/shared_keys.dart';

class OtpCubit extends Cubit<OtpState> {
  final OtpService otpService;

  OtpCubit(this.otpService) : super(OtpInitial());

  int timer = 20;
  bool isCounting = false;

  // ================== VERIFY OTP ==================
  Future<void> verifyCode(String email, String code) async {
    if (code.length != 6) {
      emit(OtpError("Enter full OTP"));
      return;
    }

    emit(OtpLoading());

    try {
      final response = await otpService.verifyOtp(
        email: email,
        otpCode: code,
      );

      final data = response.data;

      if (data['success'] == true) {
        final token = data['data']?['token'];
        final refreshToken = data['data']?['refreshToken'];

        if (token != null) {
          await SharedHandler.instance.setString(SharedKeys.token, token);
        }
        if (refreshToken != null) {
          await SharedHandler.instance.setString('refreshToken', refreshToken);
        }

        emit(OtpSuccess());
      } else {
        emit(OtpError(data['message'] ?? "Invalid OTP"));
      }
    } on DioException catch (_) {
      emit(OtpError("OTP verification failed"));
    } catch (_) {
      emit(OtpError("Unexpected error"));
    }
  }

  // ================== RESEND OTP ==================
  Future<void> resendCode(String email) async {
    emit(OtpLoading());
    try {
      final response = await otpService.resendOtp(email: email);

      startTimer();

      final data = response.data;

      if (data['success'] == true) {
        final token = data['data']?['token'];
        final refreshToken = data['data']?['refreshToken'];

        if (token != null) {
          await SharedHandler.instance.setString(SharedKeys.token, token);
        }
        if (refreshToken != null) {
          await SharedHandler.instance.setString('refreshToken', refreshToken);
        }

        emit(OtpSuccess());
      } else {
        emit(OtpError(data['message'] ?? "Unable to resend OTP"));
      }
    } on DioException catch (_) {
      emit(OtpError("OTP resend failed"));
    } catch (_) {
      emit(OtpError("Unexpected error"));
    }
  }

  // ================== TIMER ==================
  void startTimer() {
    if (isCounting) return;

    timer = 20;
    isCounting = true;
    emit(OtpTimerChanged(timer));

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      timer--;
      emit(OtpTimerChanged(timer));

      if (timer <= 0) {
        isCounting = false;
        return false;
      }
      return true;
    });
  }
}
