import 'package:flutter/material.dart';
import 'package:rewise_kit/core/extensions/string_ext.dart';
import 'package:rewise_kit/core/extensions/theme_mode_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache.dart';

class CacheHelper {
  const CacheHelper(this._prefs);

  final SharedPreferences _prefs;

  static const _themeModeKey = 'themeMode';

  Future<void> cacheThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(_themeModeKey, themeMode.stringValue);
    Cache.instance.setThemeMode(themeMode);
  }

  ThemeMode getThemeMode() {
    final themeModeString = _prefs.getString(_themeModeKey);
    final themeMode = themeModeString?.toThemeMode ?? ThemeMode.system;
    Cache.instance.setThemeMode(themeMode);
    return themeMode;
  }
}
