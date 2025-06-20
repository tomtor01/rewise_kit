import 'package:flutter/material.dart';
import '../common/app/cache/cache.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the current locale of the app.
  Locale get locale => Localizations.localeOf(this);

  bool get isDarkMode {
    return switch (Cache.instance.themeModeNotifier.value) {
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(this) == Brightness.dark,
      ThemeMode.dark => true,
      _ => false,
    };
  }

  bool get isLightMode => !isDarkMode;
}
