import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  String get stringValue {
    switch (this) {
      case ThemeMode.system:
        return 'system';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
    }
  }
}
