import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/auth_validation_controller.dart';
import '../controllers/auth_validators.dart';
import 'form_widget_styles.dart';

class AuthFormFieldFactory {
  static Widget createEmailField({
    required BuildContext context, // Kontekst widgetu wywołującego
    required WidgetRef ref,
    required TextEditingController controller,
    required String fieldName,
    required String label,
    required FocusNode focusNode,
    void Function(String)? onFieldSubmitted,
    TextInputAction textInputAction = TextInputAction.next,
    bool manageErrorTextManually = false,
    Iterable<String>? autofillHints
  }) {
    final validationControllerNtf = ref.read(
      authValidationControllerProvider.notifier,
    );
    final authValidationState = ref.watch(authValidationControllerProvider);
    const actualValidator = AuthValidators.validateEmail;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: FormStyles.getInputDecoration(
        context: context,
        label: label,
      ).copyWith(
        errorText:
            manageErrorTextManually
                ? authValidationState.fieldErrors[fieldName]
                : null,
      ),
      keyboardType: TextInputType.emailAddress,
      autofillHints: autofillHints,
      autovalidateMode:
          manageErrorTextManually
              ? AutovalidateMode.disabled
              : AutovalidateMode.onUserInteraction,
      validator: manageErrorTextManually ? null : actualValidator,
      onChanged: (value) {
        Future(() {
          if (!context.mounted) return;
          if (manageErrorTextManually) {
            validationControllerNtf.clearFieldError(fieldName);
          }
          validationControllerNtf.resetFieldValidation(fieldName);
        });
      },
      onTapOutside: (event) {
        if (!context.mounted) {
          return; // Sprawdzenie przed FocusScope, jeśli kontekst mógłby być już usunięty
        }
        FocusScope.of(context).unfocus();
        Future(() {
          if (!context.mounted) return;
          validationControllerNtf.markFieldAsValidated(fieldName);
          if (manageErrorTextManually) {
            validationControllerNtf.validateAndStoreError(
              fieldName,
              controller.text,
              actualValidator,
            );
          }
        });
      },
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
    );
  }

  static Widget createPasswordField({
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController controller,
    required String fieldName,
    required String label,
    required FocusNode focusNode,
    required AutoDisposeStateProvider<bool> visibilityProvider,
    void Function(String)? onFieldSubmitted,
    String? Function(String?)? customValidator,
    TextInputAction textInputAction = TextInputAction.done,
    bool enableStrengthIndicator = false,
    bool manageErrorTextManually = false,
    Iterable<String>? autofillHints
  }) {
    final validationControllerNtf = ref.read(
      authValidationControllerProvider.notifier,
    );
    final authValidationState = ref.watch(authValidationControllerProvider);
    final isPasswordVisible = ref.watch(visibilityProvider);
    final actualValidator = customValidator ?? AuthValidators.validatePassword;

    Widget field = TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: !isPasswordVisible,
      autofillHints: autofillHints,
      decoration: FormStyles.getInputDecoration(
        context: context,
        label: label,
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          onPressed: () {
            if (!context.mounted) return;
            ref.read(visibilityProvider.notifier).state = !isPasswordVisible;
          },
        ),
      ).copyWith(
        errorText:
            manageErrorTextManually
                ? authValidationState.fieldErrors[fieldName]
                : null,
      ),
      autovalidateMode:
          manageErrorTextManually
              ? AutovalidateMode.disabled
              : AutovalidateMode.onUserInteraction,
      validator: manageErrorTextManually ? null : actualValidator,
      onChanged: (value) {
        Future(() {
          if (!context.mounted) return;
          if (enableStrengthIndicator || fieldName == 'password') {
            validationControllerNtf.updatePasswordStrength(value);
          }
          if (manageErrorTextManually) {
            validationControllerNtf.clearFieldError(fieldName);
          }
          validationControllerNtf.resetFieldValidation(fieldName);
        });
      },
      onTapOutside: (event) {
        if (!context.mounted) return;
        FocusScope.of(context).unfocus();
        Future(() {
          if (!context.mounted) return;
          validationControllerNtf.markFieldAsValidated(fieldName);
          if (manageErrorTextManually) {
            validationControllerNtf.validateAndStoreError(
              fieldName,
              controller.text,
              actualValidator,
            );
          }
        });
      },
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
    );

    if (enableStrengthIndicator) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          field,
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 4.0, right: 4.0),
            child: PasswordStrengthIndicator(
              strength: authValidationState.passwordStrength,
            ),
          ),
        ],
      );
    }
    return field;
  }

  static Widget createUsernameField({
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController controller,
    required String fieldName,
    required String label,
    required FocusNode focusNode,
    void Function(String)? onFieldSubmitted,
    TextInputAction textInputAction = TextInputAction.next,
    List<TextInputFormatter>? inputFormatters,
    bool manageErrorTextManually = false,
  }) {
    final validationControllerNtf = ref.read(
      authValidationControllerProvider.notifier,
    );
    final authValidationState = ref.watch(authValidationControllerProvider);
    const actualValidator = AuthValidators.validateUsername;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      decoration: FormStyles.getInputDecoration(
        context: context,
        label: label,
      ).copyWith(
        errorText:
            manageErrorTextManually
                ? authValidationState.fieldErrors[fieldName]
                : null,
      ),
      keyboardType: TextInputType.text,
      autofillHints: const [AutofillHints.username, AutofillHints.nickname],
      autovalidateMode:
          manageErrorTextManually
              ? AutovalidateMode.disabled
              : AutovalidateMode.onUserInteraction,
      validator: manageErrorTextManually ? null : actualValidator,
      inputFormatters: inputFormatters,
      onChanged: (value) {
        Future(() {
          if (!context.mounted) return;
          if (manageErrorTextManually) {
            validationControllerNtf.clearFieldError(fieldName);
          }
          validationControllerNtf.resetFieldValidation(fieldName);
        });
      },
      onTapOutside: (event) {
        if (!context.mounted) return;
        FocusScope.of(context).unfocus();
        Future(() {
          if (!context.mounted) return;
          validationControllerNtf.markFieldAsValidated(fieldName);
          if (manageErrorTextManually) {
            validationControllerNtf.validateAndStoreError(
              fieldName,
              controller.text,
              actualValidator,
            );
          }
        });
      },
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
    );
  }
}

class PasswordStrengthIndicator extends StatelessWidget {
  final double strength;

  const PasswordStrengthIndicator({super.key, required this.strength});

  @override
  Widget build(BuildContext context) {
    final color = FormStyles.getStrengthColor(strength);
    String strengthText;
    if (strength <= 0.01) {
      strengthText = '';
    } else if (strength < 0.35) {
      strengthText = 'Słabe';
    } else if (strength < 0.7) {
      strengthText = 'Średnie';
    } else {
      strengthText = 'Mocne';
    }
    if (strengthText.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 6,
            decoration: FormStyles.getStrengthIndicatorBackgroundDecoration(
              context,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: strength.clamp(0.0, 1.0),
                child: Container(
                  decoration: FormStyles.getStrengthBarDecoration(color),
                ),
              ),
            ),
          ),
        ),
        if (strengthText.isNotEmpty) ...[
          const SizedBox(width: 8),
          Text(
            strengthText,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: color),
          ),
        ],
      ],
    );
  }
}
