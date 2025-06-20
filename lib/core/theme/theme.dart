import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3e5f90),
      surfaceTint: Color(0xff3e5f90),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd5e3ff),
      onPrimaryContainer: Color(0xff254777),
      secondary: Color(0xff3f5f90),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd6e3ff),
      onSecondaryContainer: Color(0xff254777),
      tertiary: Color(0xff03677e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb4ebff),
      onTertiaryContainer: Color(0xff004e5f),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff191c20),
      onSurfaceVariant: Color(0xff43474e),
      outline: Color(0xff74777f),
      outlineVariant: Color(0xffc4c6cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3035),
      inversePrimary: Color(0xffa8c8ff),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001b3c),
      primaryFixedDim: Color(0xffa8c8ff),
      onPrimaryFixedVariant: Color(0xff254777),
      secondaryFixed: Color(0xffd6e3ff),
      onSecondaryFixed: Color(0xff001b3c),
      secondaryFixedDim: Color(0xffa8c8ff),
      onSecondaryFixedVariant: Color(0xff254777),
      tertiaryFixed: Color(0xffb4ebff),
      onTertiaryFixed: Color(0xff001f28),
      tertiaryFixedDim: Color(0xff87d1ea),
      onTertiaryFixedVariant: Color(0xff004e5f),
      surfaceDim: Color(0xffd9d9e0),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffededf4),
      surfaceContainerHigh: Color(0xffe7e8ee),
      surfaceContainerHighest: Color(0xffe1e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0f3665),
      surfaceTint: Color(0xff3e5f90),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4e6ea0),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff103665),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff4e6ea0),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003c4a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff22768d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff0f1116),
      onSurfaceVariant: Color(0xff33363d),
      outline: Color(0xff4f525a),
      outlineVariant: Color(0xff6a6d75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3035),
      inversePrimary: Color(0xffa8c8ff),
      primaryFixed: Color(0xff4e6ea0),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff345586),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4e6ea0),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff355586),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff22768d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff005d71),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc5c6cd),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3fa),
      surfaceContainer: Color(0xffe7e8ee),
      surfaceContainerHigh: Color(0xffdcdce3),
      surfaceContainerHighest: Color(0xffd0d1d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002c5a),
      surfaceTint: Color(0xff3e5f90),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff274a79),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff002c5a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff284979),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00313d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff005062),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff292c33),
      outlineVariant: Color(0xff464951),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3035),
      inversePrimary: Color(0xffa8c8ff),
      primaryFixed: Color(0xff274a79),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff093361),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff284979),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff0a3261),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff005062),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003845),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb7b8bf),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f0f7),
      surfaceContainer: Color(0xffe1e2e9),
      surfaceContainerHigh: Color(0xffd3d4db),
      surfaceContainerHighest: Color(0xffc5c6cd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa8c8ff),
      surfaceTint: Color(0xffa8c8ff),
      onPrimary: Color(0xff05305f),
      primaryContainer: Color(0xff254777),
      onPrimaryContainer: Color(0xffd5e3ff),
      secondary: Color(0xffa8c8ff),
      onSecondary: Color(0xff06305f),
      secondaryContainer: Color(0xff254777),
      onSecondaryContainer: Color(0xffd6e3ff),
      tertiary: Color(0xff87d1ea),
      onTertiary: Color(0xff003542),
      tertiaryContainer: Color(0xff004e5f),
      onTertiaryContainer: Color(0xffb4ebff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111318),
      onSurface: Color(0xffe1e2e9),
      onSurfaceVariant: Color(0xffc4c6cf),
      outline: Color(0xff8e9199),
      outlineVariant: Color(0xff43474e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e9),
      inversePrimary: Color(0xff3e5f90),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001b3c),
      primaryFixedDim: Color(0xffa8c8ff),
      onPrimaryFixedVariant: Color(0xff254777),
      secondaryFixed: Color(0xffd6e3ff),
      onSecondaryFixed: Color(0xff001b3c),
      secondaryFixedDim: Color(0xffa8c8ff),
      onSecondaryFixedVariant: Color(0xff254777),
      tertiaryFixed: Color(0xffb4ebff),
      onTertiaryFixed: Color(0xff001f28),
      tertiaryFixedDim: Color(0xff87d1ea),
      onTertiaryFixedVariant: Color(0xff004e5f),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff37393e),
      surfaceContainerLowest: Color(0xff0c0e13),
      surfaceContainerLow: Color(0xff191c20),
      surfaceContainer: Color(0xff1d2024),
      surfaceContainerHigh: Color(0xff282a2f),
      surfaceContainerHighest: Color(0xff33353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffccddff),
      surfaceTint: Color(0xffa8c8ff),
      onPrimary: Color(0xff00254e),
      primaryContainer: Color(0xff7292c6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffccddff),
      onSecondary: Color(0xff00254e),
      secondaryContainer: Color(0xff7292c6),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa1e6ff),
      onTertiary: Color(0xff002a35),
      tertiaryContainer: Color(0xff4f9ab2),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdadce5),
      outline: Color(0xffafb2bb),
      outlineVariant: Color(0xff8d9099),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e9),
      inversePrimary: Color(0xff264878),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001129),
      primaryFixedDim: Color(0xffa8c8ff),
      onPrimaryFixedVariant: Color(0xff0f3665),
      secondaryFixed: Color(0xffd6e3ff),
      onSecondaryFixed: Color(0xff00112a),
      secondaryFixedDim: Color(0xffa8c8ff),
      onSecondaryFixedVariant: Color(0xff103665),
      tertiaryFixed: Color(0xffb4ebff),
      onTertiaryFixed: Color(0xff00141a),
      tertiaryFixedDim: Color(0xff87d1ea),
      onTertiaryFixedVariant: Color(0xff003c4a),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff42444a),
      surfaceContainerLowest: Color(0xff06070c),
      surfaceContainerLow: Color(0xff1b1e22),
      surfaceContainer: Color(0xff26282d),
      surfaceContainerHigh: Color(0xff303338),
      surfaceContainerHighest: Color(0xff3b3e43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeaf0ff),
      surfaceTint: Color(0xffa8c8ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa4c4fb),
      onPrimaryContainer: Color(0xff000b1f),
      secondary: Color(0xffebf0ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffa4c4fb),
      onSecondaryContainer: Color(0xff000b1f),
      tertiary: Color(0xffdaf4ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff83cde6),
      onTertiaryContainer: Color(0xff000d12),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff111318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffeef0f9),
      outlineVariant: Color(0xffc0c2cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e2e9),
      inversePrimary: Color(0xff264878),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa8c8ff),
      onPrimaryFixedVariant: Color(0xff001129),
      secondaryFixed: Color(0xffd6e3ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffa8c8ff),
      onSecondaryFixedVariant: Color(0xff00112a),
      tertiaryFixed: Color(0xffb4ebff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff87d1ea),
      onTertiaryFixedVariant: Color(0xff00141a),
      surfaceDim: Color(0xff111318),
      surfaceBright: Color(0xff4e5055),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1d2024),
      surfaceContainer: Color(0xff2e3035),
      surfaceContainerHigh: Color(0xff393b41),
      surfaceContainerHighest: Color(0xff45474c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
