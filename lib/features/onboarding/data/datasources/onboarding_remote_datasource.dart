import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../../configuration/network/end_point.dart';
import '../models/user_preferences_model.dart';
import '../models/user_preferences_options_model.dart';

abstract class OnboardingRemoteDataSource {
  Future<void> saveUserPreferences(UserPreferencesModel model);

  Future<UserPreferencesOptionsModel> getOptions();

}

class OnboardingRemoteDataSourceImpl
    implements OnboardingRemoteDataSource {
  final Dio dio;

  OnboardingRemoteDataSourceImpl(this.dio);

  @override
  Future<UserPreferencesOptionsModel> getOptions() async {
    final response = await dio.get(AppEndPoint.userPreferencesOptions);
    return UserPreferencesOptionsModel.fromJson(response.data);
  }
  @override
  Future<void> saveUserPreferences(UserPreferencesModel model) async {
    debugPrint("🚀 POST UserPreferences START");
    debugPrint(model.toJson().toString());

    final response = await dio.post(
      AppEndPoint.userPreferences,
        data: model.toJson(),
    );

    debugPrint("✅ POST UserPreferences DONE");
    debugPrint(response.data.toString());
  }


}
