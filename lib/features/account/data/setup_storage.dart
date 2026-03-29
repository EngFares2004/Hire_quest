import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../domain/models/interview_setup.dart';

class SetupStorage {
  static const String key = 'interview_setup';

  static Future<void> saveSetup(InterviewSetupModel setup) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(setup.toJson()); // تحويل لـ JSON
    await prefs.setString(key, jsonString);
  }

  static Future<InterviewSetupModel?> getSetup() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return InterviewSetupModel.fromJson(jsonMap);
  }

  static Future<void> clearSetup() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
