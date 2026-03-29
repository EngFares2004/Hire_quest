import 'package:flutter/material.dart';
import 'package:hire_quest/configuration/theme/theme.dart';

abstract class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppTheme.backgroundWhite,
    primaryColor: AppTheme.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTheme.white,
      foregroundColor: AppTheme.black,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppTheme.black,
    primaryColor: AppTheme.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTheme.black,
      foregroundColor: AppTheme.white,
      elevation: 0,
    ),
  );
}
