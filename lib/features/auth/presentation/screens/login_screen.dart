import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_title.dart';
import '../app/adapters/auth_adapter.dart';
import '../controllers/auth_validation_controller.dart';
import '../controllers/auth_validators.dart';
import '../widgets/auth_form_field_factory.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide SignedIn;

class LoginScreen extends ConsumerStatefulWidget {
  static const path = '/login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authAdapter = authAdapterProvider;

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;

  static const String _emailField = 'email';
  static const String _passwordField = 'password';

  @override
  void initState() {
    super.initState();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _emailFocusNode.addListener(_onEmailFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resetFormState();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.removeListener(_onEmailFocusChange);
    _emailFocusNode.dispose();
    _passwordFocusNode.removeListener(_onPasswordFocusChange);
    _passwordFocusNode.dispose();

    super.dispose();
  }

  void _onEmailFocusChange() {
    if (!_emailFocusNode.hasFocus) {
      // Waliduj tylko gdy fokus jest tracony
      Future(() {
        // Opóźnienie modyfikacji stanu
        final validationControllerNtf = ref.read(
          authValidationControllerProvider.notifier,
        );
        validationControllerNtf.markFieldAsValidated(_emailField);
        validationControllerNtf.validateAndStoreError(
          _emailField,
          _emailController.text,
          AuthValidators.validateEmail,
        );
      });
    }
  }

  void _onPasswordFocusChange() {
    if (!_passwordFocusNode.hasFocus) {
      // Waliduj tylko gdy fokus jest tracony
      Future(() {
        // Opóźnienie modyfikacji stanu
        final validationControllerNtf = ref.read(
          authValidationControllerProvider.notifier,
        );
        validationControllerNtf.markFieldAsValidated(_passwordField);
        validationControllerNtf.validateAndStoreError(
          _passwordField,
          _passwordController.text,
          AuthValidators.validatePassword, // Lub customValidator, jeśli jest
        );
      });
    }
  }

  void _resetFormState() {
    _emailController.clear();
    _passwordController.clear();

    ref
        .read(authValidationControllerProvider.notifier)
        .resetAllValidationStates();

    if (_formKey.currentState != null) {
      _formKey.currentState!.reset();
    }
  }

  Future<void> _submitForm() async {
    final validationNotifier = ref.read(
      authValidationControllerProvider.notifier,
    );
    final emailText = _emailController.text.trim();
    final passwordText = _passwordController.text.trim();

    // Wymusza walidację dla pól przed sprawdzeniem (na wypadek gdyby nie straciły fokusu)
    validationNotifier.validateAndStoreError(
      _emailField,
      emailText,
      AuthValidators.validateEmail,
    );
    validationNotifier.markFieldAsValidated(_emailField);

    validationNotifier.validateAndStoreError(
      _passwordField,
      passwordText,
      AuthValidators.validatePassword,
    );
    validationNotifier.markFieldAsValidated(_passwordField);

    await Future.delayed(Duration.zero); // Daje szansę na przetworzenie stanu

    final currentValidationState = ref.read(authValidationControllerProvider);
    bool hasErrors = currentValidationState.fieldErrors.values.any(
      (error) => error != null && error.isNotEmpty,
    );

    if (hasErrors) {
      return;
    }

    TextInput.finishAutofillContext(shouldSave: true);
    final authNotifier = ref.read(_authAdapter.notifier);
    try {
      await authNotifier.signIn(email: emailText, password: passwordText);

      // final authState = ref.read(_authAdapter);
      // if (authState is SignedIn && mounted) {
      //   context.pop();
      // }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Wystąpił błąd: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(_authAdapter);

    return Scaffold(
      key: const ValueKey('login-form'),
      appBar: AppBar(title: const Text('Logowanie')),
      body:
           Center(
                child:authState is AuthLoading
                    ? const CircularProgressIndicator()
                    : SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      margin: const EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: AutofillGroup(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: AppTitle(
                                    prefix: 'Witaj ponownie w\n',
                                    useGradient: true,
                                    fontSize: 29,
                                  ),
                                ),
                                const SizedBox(height: 24),

                                if (authState is AuthFailure)
                                  Text(authState.message),

                                _buildLoginForm(),
                                const SizedBox(height: 24),
                                FilledButton(
                                  onPressed:
                                      authState is AuthLoading
                                          ? null
                                          : _submitForm,
                                  style: FilledButton.styleFrom(
                                    minimumSize: const Size(
                                      double.infinity,
                                      40,
                                    ),
                                  ),
                                  child: const Text('Zaloguj się'),
                                ),
                                const SizedBox(height: 12),
                                TextButton(
                                  onPressed:
                                      authState is AuthLoading
                                          ? null
                                          : () {
                                            _resetFormState();
                                            context.replace('/register');
                                          },
                                  child: const Text(
                                    'Nie masz konta? Zarejestruj się!',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthFormFieldFactory.createEmailField(
          context: context,
          controller: _emailController,
          fieldName: _emailField,
          ref: ref,
          label: 'Adres e-mail',
          focusNode: _emailFocusNode,
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          manageErrorTextManually: true,
          autofillHints: const [AutofillHints.email],
        ),
        const SizedBox(height: 16),
        AuthFormFieldFactory.createPasswordField(
          context: context,
          controller: _passwordController,
          fieldName: _passwordField,
          ref: ref,
          label: 'Wpisz hasło',
          focusNode: _passwordFocusNode,
          customValidator: null,
          visibilityProvider: loginPasswordVisibilityProvider,
          onFieldSubmitted: (_) => _submitForm(),
          manageErrorTextManually: true,
          autofillHints: const [AutofillHints.password],
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (context) => const ForgotPasswordScreen()
              ).then((email) {
                if (email != null && mounted) {
                  _resetFormState();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Link do resetowania hasła został wysłany na adres: $email',
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      duration: const Duration(seconds: 5),
                    ),
                  );
                }
              });
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(8.0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Nie pamiętasz hasła?',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
