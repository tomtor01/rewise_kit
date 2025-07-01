import 'package:flutter/material.dart';

/// Klasa zawierająca style i dekoracje dla formularzy specyficznych dla modułu Auth.
class FormStyles {
  /// Zwraca podstawową dekorację pola formularza dla modułu Auth.
  static InputDecoration getInputDecoration({
    required BuildContext context,
    required String label,
    String? hintText,
    String? helperText,
    int? helperMaxLines,
    Widget? suffixIcon,
    EdgeInsetsGeometry? contentPadding, // Allow custom content padding
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InputDecoration(
      labelText: label,
      hintText: hintText,
      helperText: helperText,
      helperMaxLines: helperMaxLines,
      suffixIcon: suffixIcon,
      errorStyle: TextStyle(color: colorScheme.error, fontSize: 12),
      filled: true,
      fillColor: colorScheme.surfaceContainerLow,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), // Common M3 radius
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
      contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  /// Zwraca styl dla tła paska siły hasła.
  static BoxDecoration getStrengthIndicatorBackgroundDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(4), // Consistent rounding
    );
  }

  /// Zwraca styl dla wypełnienia paska siły hasła.
  static BoxDecoration getStrengthBarDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    );
  }

  /// Zwraca kolor dla paska siły hasła na podstawie wartości siły.
  static Color getStrengthColor(double strength) {
    if (strength <= 0.01) return Colors.transparent;
    if (strength < 0.35) return Colors.redAccent.shade400;
    if (strength < 0.7) return Colors.orangeAccent.shade400;
    return Colors.greenAccent.shade700;
  }

  /// Styl dla przycisku formularza.
  static ButtonStyle getSubmitButtonStyle(BuildContext context, {bool fullWidth = true}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      disabledBackgroundColor: colorScheme.onSurface.withValues(alpha: 0.12),
      disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.38),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: theme.textTheme.labelLarge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Full capsule shape
      ),
      minimumSize: fullWidth ? const Size(double.infinity, 48) : null,
      elevation: 2,
    );
  }

  /// Styl dla przycisku tekstowego (np. "Zapomniałeś hasła?")
  static ButtonStyle getTextButtonStyle(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextButton.styleFrom(
      foregroundColor: colorScheme.primary,
      textStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.normal),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}