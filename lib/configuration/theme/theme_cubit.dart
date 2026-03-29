import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared_handler/shared_handler.dart';
import '../shared_handler/shared_keys.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_loadTheme());

  static ThemeMode _loadTheme() {
    final mode = SharedHandler.instance.getString(SharedKeys.isDarkMode);

    switch (mode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  void changeTheme(ThemeMode mode) {
    SharedHandler.instance.setString(
      SharedKeys.isDarkMode,
      mode.name,
    );
    emit(mode);
  }
}
