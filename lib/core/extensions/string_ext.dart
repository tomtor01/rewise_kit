import 'package:flutter/material.dart';

extension StringExtension on String {
  ThemeMode get toThemeMode {
    switch (this) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
