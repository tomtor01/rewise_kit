import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rewise_kit/core/extensions/string_ext.dart';
import 'package:rewise_kit/core/extensions/theme_mode_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache.dart';

class CacheHelper {
  const CacheHelper(this._prefs, this._secureStorage);

  final SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage;

  static const _sessionTokenKey = 'sessionToken';
  static const _userIdKey = 'userId';
  static const _themeModeKey = 'themeMode';

  Future<bool> cacheSessionToken(String token) async {
    try {
      await _secureStorage.write(key: _sessionTokenKey, value: token);
      Cache.instance.setSessionToken(token);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cacheUserId(String id) async {
    try {
      final result = await _prefs.setString(_userIdKey, id);
      Cache.instance.setUserId(id);
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<void> cacheThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(_themeModeKey, themeMode.stringValue);
    Cache.instance.setThemeMode(themeMode);
  }

  Future<String?> getSessionToken() async {
    try {
      String? token = Cache.instance.sessionToken;

      if (token == null) {
        token = await _secureStorage.read(key: _sessionTokenKey);
        if (token != null) {
          Cache.instance.setSessionToken(token);
        }
      }
      return token;
    } catch (e) {
      debugPrint("Błąd podczas pobierania tokenu: $e");
      return null;
    }
  }

  String? getUserId() {
    final userId = _prefs.getString(_userIdKey);
    if (userId case String()) {
      Cache.instance.setUserId(userId);
    }
    return userId;
  }

  ThemeMode getThemeMode() {
    final themeModeString = _prefs.getString(_themeModeKey);
    final themeMode = themeModeString?.toThemeMode ?? ThemeMode.system;
    Cache.instance.setThemeMode(themeMode);
    return themeMode;
  }

  Future<void> resetSession() async {
    await _prefs.remove(_userIdKey);
    await _secureStorage.delete(key: _sessionTokenKey);
    Cache.instance.resetSession();
  }
}
