import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

// Stan walidacji
class AuthValidationState extends Equatable {
  final double passwordStrength;
  final Map<String, bool> validatedFields; // Klucz: nazwa pola, Wartość: czy zostało "dotknięte"
  final Map<String, String?> fieldErrors; // Przechowuje aktualne błędy walidacji dla pól

  const AuthValidationState({
    this.passwordStrength = 0.0,
    this.validatedFields = const {},
    this.fieldErrors = const {},
  });

  AuthValidationState copyWith({
    double? passwordStrength,
    Map<String, bool>? validatedFields,
    Map<String, String?>? fieldErrors,
  }) {
    return AuthValidationState(
      passwordStrength: passwordStrength ?? this.passwordStrength,
      validatedFields: validatedFields ?? this.validatedFields,
      fieldErrors: fieldErrors ?? this.fieldErrors,
    );
  }

  @override
  List<Object?> get props => [passwordStrength, validatedFields, fieldErrors];
}

// Kontroler walidacji
class AuthValidationController extends StateNotifier<AuthValidationState> {
  AuthValidationController() : super(const AuthValidationState());

  void updatePasswordStrength(String password) {
    final strength = _calculatePasswordStrength(password);
    state = state.copyWith(passwordStrength: strength);
  }

  void markFieldAsValidated(String fieldName) {
    final newValidatedFields = Map<String, bool>.from(state.validatedFields);
    newValidatedFields[fieldName] = true;
    state = state.copyWith(validatedFields: newValidatedFields);
  }

  void resetFieldValidation(String fieldName) {
    final newValidatedFields = Map<String, bool>.from(state.validatedFields);
    if (newValidatedFields.containsKey(fieldName)) {
      newValidatedFields[fieldName] = false;
      state = state.copyWith(validatedFields: newValidatedFields);
    }
    // Dodatkowo czyścimy błąd, jeśli zarządzamy nim manualnie
    clearFieldError(fieldName);
  }

  void validateAllFields(List<String> fieldNames) {
    final newValidatedFields = Map<String, bool>.from(state.validatedFields);
    for (final fieldName in fieldNames) {
      newValidatedFields[fieldName] = true;
    }
    state = state.copyWith(validatedFields: newValidatedFields);
  }

  void resetAllValidationStates() {
    state = const AuthValidationState(); // To automatycznie zresetuje fieldErrors do {}
  }

  // Czyści manualnie zarządzany błąd dla pola
  void clearFieldError(String fieldName) {
    final newErrors = Map<String, String?>.from(state.fieldErrors);
    if (newErrors.containsKey(fieldName)) {
      newErrors[fieldName] = null; // lub newErrors.remove(fieldName);
      state = state.copyWith(fieldErrors: newErrors);
    }
  }

  void validateAndStoreError(
      String fieldName,
      String value,
      String? Function(String?) actualValidator,
      ) {
    final error = actualValidator(value);
    final newErrors = Map<String, String?>.from(state.fieldErrors);
    newErrors[fieldName] = error;
    state = state.copyWith(fieldErrors: newErrors);
  }

  bool fieldShouldShowError(String fieldName, String? currentValidationError) {
    return (state.validatedFields[fieldName] ?? false) && currentValidationError != null;
  }

  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;

    double strength = 0.0;
    bool lengthOkForBonus = false;
    int requirementsMet = 0; // Licznik spełnionych wymagań

    const double strongLengthThreshold = 12;
    const double goodLengthThreshold = 8;
    const double minLengthThreshold = 4;

    // 1. Punkty za długość (maks. 0.30)
    if (password.length >= strongLengthThreshold) {
      lengthOkForBonus = true;
      strength += 0.30;
    } else if (password.length >= goodLengthThreshold) {
      lengthOkForBonus = true;
      strength += 0.15 + (0.15 * (password.length - goodLengthThreshold) / (strongLengthThreshold - goodLengthThreshold));
    } else if (password.length >= minLengthThreshold) {
      strength += 0.05 + (0.05 * (password.length - minLengthThreshold) / (goodLengthThreshold - minLengthThreshold));
    } else {
      // Dla haseł krótszych niż minLengthThreshold (np. < 6 znaków)
      strength += 0.01;
    }

    // 2. Punkty za typy znaków (każdy typ po 0.15, maks. 0.60)
    bool hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    bool hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    bool hasDigit = RegExp(r'[0-9]').hasMatch(password);
    bool hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    if (hasUppercase) {
      strength += 0.15;
      requirementsMet++;
    }
    if (hasLowercase) {
      strength += 0.15;
      requirementsMet++;
    }
    if (hasDigit) {
      strength += 0.15;
      requirementsMet++;
    }
    if (hasSpecialChar) {
      strength += 0.15;
      requirementsMet++;
    }

    // 3. Bonus za "kompletność" i różnorodność (maks. 0.15)
    if (lengthOkForBonus) { // Długość co najmniej "dobra" (8+)
      if (requirementsMet == 4) {
        strength += 0.15;
      } else if (requirementsMet == 3) {
        strength += 0.1;
      } else if (requirementsMet == 2) {
        strength += 0.05;
      }
    }
    return strength.clamp(0.0, 1.0);
  }
}

final authValidationControllerProvider =
StateNotifierProvider<AuthValidationController, AuthValidationState>(
      (ref) => AuthValidationController(),
);

final loginPasswordVisibilityProvider = StateProvider.autoDispose<bool>((ref) => false);
final registerPasswordVisibilityProvider = StateProvider.autoDispose<bool>((ref) => false);
final confirmPasswordVisibilityProvider = StateProvider.autoDispose<bool>((ref) => false);

enum ValidationBehavior {
  onUserInteraction,
  onLostFocus,
}
