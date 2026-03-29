import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../../../configuration/shared_handler/shared_handler.dart';
import '../../../../configuration/shared_handler/shared_keys.dart';
import '../../domain/model_data/login_data.dart';
import '../../domain/services/login_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<AppEvent, AppState> {
  LoginBloc() : super(InitialState()) {
    on<LoginEvent>(_login);
    on<LoadSavedUserEvent>(_loadSavedUser);
    on<LoadTokenEvent>(_loadToken);
  }

  // ===== Controllers =====
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ===== Auth Service =====
  final LoginService loginService = LoginService();

  // ============================
  //      LOGIN FUNCTION
  // ============================
  Future<void> _login(LoginEvent event, Emitter<AppState> emit) async {
    emit(LoadingState());

    try {
      log("===== LOGIN REQUEST =====");
      log("Email: ${event.email}");
      log("Password: ${event.password}");

      final response = await loginService.login(event.email, event.password);

      log("===== LOGIN RESPONSE =====");
      log("Response Data: $response");

      final token = response['data']?['token'];
      final message = response['message']?.toString() ?? "Login failed";

      if (token != null && token.isNotEmpty) {
        // ===== Save Token =====
        await SharedHandler.instance.setString(SharedKeys.token, token);

        // ===== Save User =====
        final user = LoginData(
          email: event.email,
          password: event.password,
        );
        await SharedHandler.instance.setString(
          SharedKeys.user,
          jsonEncode(user.toJson()),
        );

        // ===== Save login flag =====
        await SharedHandler.instance.setString(SharedKeys.isLogin, 'true');

        emit(SuccessState(data: "Login Successful"));
      } else {
        emit(FailureState(error: message));
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map<String, dynamic>
          ? e.response?.data['message']?.toString()
          : e.response?.data.toString();

      emit(FailureState(
        error: errorMessage ?? "Login failed, please try again",
      ));
    } catch (e) {
      log("===== OTHER EXCEPTION =====");
      emit(FailureState(error: "Network error: ${e.toString()}"));
    }
  }

  // =========================================
  //        READ SAVED USER FROM STORAGE
  // =========================================
  Future<void> _loadSavedUser(
      LoadSavedUserEvent event, Emitter<AppState> emit) async {
    final userJson = SharedHandler.instance.getString(SharedKeys.user);

    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      final email = userMap["email"];
      final password = userMap["password"];

      emit(LoadedUserState(email: email, password: password));
    } else {
      emit(FailureState(error: "No saved user found"));
    }
  }

  // =========================================
  //            READ SAVED TOKEN
  // =========================================
  Future<void> _loadToken(
      LoadTokenEvent event, Emitter<AppState> emit) async {
    final token = SharedHandler.instance.getString(SharedKeys.token);

    if (token != null) {
      emit(LoadedTokenState(token: token));
    } else {
      emit(FailureState(error: "No saved token found"));
    }
  }
}
