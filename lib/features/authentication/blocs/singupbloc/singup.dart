import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../configuration/network/end_point.dart';
import '../../../../configuration/network/dio_client.dart';
import '../../../../configuration/shared_handler/shared_handler.dart';
import '../../../../configuration/shared_handler/shared_keys.dart';
import '../../domain/services/register_response.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<AppEvent, AppState> {
  SignupBloc() : super(InitialState()) {
    on<SignupEvent>(_signup);
    on<ToggleTermsEvent>(_toggleTerms);
  }

  // ===== Controllers =====
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isAccepted = false;

  void _toggleTerms(ToggleTermsEvent event, Emitter<AppState> emit) {
    isAccepted = !isAccepted;
    emit(RefreshUIState(isAccepted: isAccepted));
  }

  final DioClient dioClient = DioClient();

  Future<void> _signup(SignupEvent event, Emitter<AppState> emit) async {
    emit(LoadingState(isAccepted: isAccepted));

    try {
      log("===== SIGNUP REQUEST =====");
      log("URL: ${AppEndPoint.register}");
      log("Request Body: ${event.userData.toJson()}");

      Response response = await dioClient.post(
        AppEndPoint.register,
        data: event.userData.toJson(),
      );

      log("===== SIGNUP RESPONSE =====");
      log("Response Data: ${response.data}");

      final registerResponse = RegisterModel.fromJson(response.data);

      if (registerResponse.data != null && registerResponse.data!.isNotEmpty) {
        await SharedHandler.instance.setString(
          SharedKeys.token,
          registerResponse.data!,
        );
        await SharedHandler.instance.setString(
          SharedKeys.user,
          jsonEncode(event.userData.toJson()),
        );
        await SharedHandler.instance.setString(SharedKeys.isLogin, "true");

        emit(
          SuccessState(
            data: registerResponse.message ?? "Registration successful.",
          ),
        );
      } else {
        emit(FailureState(error: "Token not found in response"));
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map<String, dynamic>
          ? e.response?.data['message']
          : e.response?.data.toString();

      emit(
        FailureState(
          error: errorMessage ?? "Registration failed, please try again.",
        ),
      );
    } catch (e) {
      emit(FailureState(error: "Network error: $e"));
    }
  }
}
