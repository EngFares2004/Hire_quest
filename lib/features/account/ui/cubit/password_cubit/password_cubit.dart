import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repo/change_password_service.dart';
import 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  final ChangePassService service;

  PasswordCubit(this.service) : super(PasswordInitial());

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(PasswordLoading());

    try {
      final res = await service.changePassword(
        password: oldPassword,
        newPassword: newPassword,
      );

      if (res.data["success"] == true) {
        emit(PasswordSuccess());
      } else {
        emit(PasswordError("Failed to change password"));
      }
    } catch (e) {
      emit(PasswordError(e.toString()));
    }
  }
}