import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/shared_handler/shared_handler.dart';
import '../../../../configuration/shared_handler/shared_keys.dart';
import 'reset_pass_state.dart';
import '../../domain/services/password_service.dart';

class ResetPassCubit extends Cubit<ResetPassState> {
  ResetPassCubit() : super(PasswordInitial());

  final ResetPassService service = ResetPassService();

  // ===== Controllers =====
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // ============================
  //      RESET PASSWORD FUNCTION
  // ============================
  Future<void> resetPassword() async {
    final pass = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (pass.isEmpty || confirm.isEmpty) {
      emit(PasswordError("Please fill all fields"));
      return;
    }

    if (pass != confirm) {
      emit(PasswordError("Passwords do not match"));
      return;
    }

    emit(PasswordLoading());

    try {
      final response = await service.resetPassword(newPassword: pass);
      final data = response.data;

      if (data["success"] != true) {
        final token = data["data"]["token"];
        final refreshToken = data["data"]["refreshToken"];


        await SharedHandler.instance.setString(
          SharedKeys.token,
          token,
        );
        await SharedHandler.instance.setString(
          SharedKeys.refreshToken,
          refreshToken,
        );

        emit(PasswordSuccess());
      } else {
        emit(
          PasswordError(
            data["errors"] != null && data["errors"].isNotEmpty
                ? data["errors"].first
                : data["message"] ?? "Something went wrong",
          ),
        );
      }
    } on DioException catch (_) {
      emit(PasswordSuccess());
    } catch (_) {
      emit(PasswordSuccess());
    }
  }
}
