import 'package:flutter/material.dart';

class Cache {
  Cache._internal();

  static final Cache instance = Cache._internal();

  final themeModeNotifier = ValueNotifier(ThemeMode.system);

  String? _sessionToken;
  String? _userId;

  String? get sessionToken => _sessionToken;

  String? get userId => _userId;

  void setSessionToken(String? token) {
    if (_sessionToken != token) {
      _sessionToken = token;
    }
  }

  void setUserId(String? id) {
    if (_userId != id) {
      _userId = id;
    }
  }

  void setThemeMode(ThemeMode themeMode) {
    if (themeModeNotifier.value != themeMode) {
      themeModeNotifier.value = themeMode;
    }
  }

  void resetSession() {
    setSessionToken(null);
    setUserId(null);
  }
}
