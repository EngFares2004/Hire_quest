import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../configuration/network/end_point.dart';

import '../../../account/domain/models/preferences_model.dart';

import '../models/user_preferences_model.dart';
import '../models/user_preferences_options_model.dart';

abstract class OnboardingRemoteDataSource {

  Future<void> saveUserPreferences(
      UserPreferencesModel model);

  Future<UserPreferencesOptionsModel>
  getOptions();

  Future<UserPreferencesModelEdit>
  getUserPreferences();
  Future<void> updateUserPreferences(
      UserPreferencesModelEdit model);
}

class OnboardingRemoteDataSourceImpl
    implements OnboardingRemoteDataSource {

  final Dio dio;

  OnboardingRemoteDataSourceImpl(this.dio);

  // ================= GET OPTIONS =================

  @override
  Future<UserPreferencesOptionsModel>
  getOptions() async {

    final response = await dio.get(
      AppEndPoint.userPreferencesOptions,
    );

    return UserPreferencesOptionsModel
        .fromJson(response.data);
  }

  // ================= GET USER PREFERENCES =================

  @override
  Future<UserPreferencesModelEdit>
  getUserPreferences() async {

    final response = await dio.get(
      AppEndPoint.userPreferences,
    );

    return UserPreferencesModelEdit
        .fromJson(response.data);
  }

  // ================= SAVE USER PREFERENCES =================

  @override
  Future<void> saveUserPreferences(
      UserPreferencesModel model) async {

    debugPrint("🚀 POST UserPreferences START");

    debugPrint(model.toJson().toString());

    final response = await dio.post(
      AppEndPoint.userPreferences,
      data: model.toJson(),
    );

    debugPrint("✅ POST UserPreferences DONE");

    debugPrint(response.data.toString());
  }
  // ================= UPDATE USER PREFERENCES =================

  @override
  Future<void> updateUserPreferences(
      UserPreferencesModelEdit model) async {

    final response = await dio.put(
      AppEndPoint.userPreferences,
      data: model.toJson(),
    );

    debugPrint("✅ PUT UserPreferences DONE");

    debugPrint(response.data.toString());
  }
}