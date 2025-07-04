import 'package:flutter/material.dart';

class Cache {
  Cache._internal();

  static final Cache instance = Cache._internal();

  final themeModeNotifier = ValueNotifier(ThemeMode.system);

  void setThemeMode(ThemeMode themeMode) {
    if (themeModeNotifier.value != themeMode) {
      themeModeNotifier.value = themeMode;
    }
  }
}
