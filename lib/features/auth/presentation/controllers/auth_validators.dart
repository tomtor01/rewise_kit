class AuthValidators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wprowadź hasło';
    }
    List<String> errors = [];

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      errors.add('Brak małej litery');
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      errors.add('Brak dużej litery');
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      errors.add('Brak cyfry');
    }
    if (value.length < 8) {
      errors.add('Hasło musi mieć co najmniej 8 znaków');
    }
    if (errors.isNotEmpty) {
      return errors.first; // Zwraca tylko pierwszy błąd dla uproszczenia UI
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wprowadź adres e-mail';
    }
    if (value.length > 50) {
      return 'Adres e-mail jest zbyt długi';
    }
    // Standard Flutter email regex (more robust)
    // Source: https://api.flutter.dev/flutter/widgets/EditableText/autofillHints.html
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Wprowadź poprawny adres e-mail';
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wprowadź nazwę użytkownika';
    }
    if (value.length < 3) {
      return 'Musi mieć co najmniej 3 znaki';
    }
    if (value.length > 20) {
      return 'Nie wiecej niż 20 znaków!';
    }
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_-]+$');

    if (!usernameRegex.hasMatch(value)) {
      return 'Dozwolone litery, cyfry, myślnik i podkreślenie';
    }
    return null;
  }
}
