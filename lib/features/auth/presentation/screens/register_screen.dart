import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_title.dart';
import '../app/adapters/auth_adapter.dart';
import '../controllers/auth_validation_controller.dart';
import '../controllers/auth_validators.dart';
import '../widgets/auth_form_field_factory.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  static const path = '/register';

  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _authAdapter = authAdapterProvider;
  bool _isProcessing = false;

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _passwordConfirmationFocusNode;

  static const String _emailField = 'email';
  static const String _passwordField = 'password';
  static const String _passwordConfirmField = 'password_confirm';

  @override
  void initState() {
    super.initState();

    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordConfirmationFocusNode = FocusNode();

    _emailFocusNode.addListener(_onEmailFocusChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resetFormState();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmationFocusNode.dispose();
    _emailFocusNode.removeListener(_onEmailFocusChange);
    super.dispose();
  }

  void _resetFormState() {
    _emailController.clear();
    _passwordController.clear();
    _passwordConfirmationController.clear();

    ref
        .read(authValidationControllerProvider.notifier)
        .resetAllValidationStates();

    if (_formKey.currentState != null) {
      _formKey.currentState!.reset();
    }
  }

  Future<void> _submitForm() async {
    // Oznacz wszystkie pola jako zwalidowane, aby pokazały błędy
    ref.read(authValidationControllerProvider.notifier).validateAllFields([
      _emailField,
      _passwordField,
      _passwordConfirmField,
    ]);

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isProcessing = true;
    });

    TextInput.finishAutofillContext(shouldSave: true);
    final authNotifier = ref.read(_authAdapter.notifier);

    try {
      final currentEmail = _emailController.text.trim();
      final currentPassword = _passwordController.text.trim();

      await authNotifier.signUp(email: currentEmail, password: currentPassword);

      final authState = ref.read(_authAdapter);
      if (authState is SignedUp && mounted) {
        setState(() {
          _isProcessing = false;
        });
        context.go('/');
        _resetFormState();
      } else if (authState is AuthFailure && mounted) {
        // Zachowanie wartości pól w przypadku błędów
        setState(() {
          _isProcessing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(_authAdapter);

    return Scaffold(
      key: const ValueKey('register-form'),
      appBar: AppBar(
        title: const Text('Rejestracja'),
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          if (_isProcessing && authState is! AuthLoading)
            const LinearProgressIndicator(),
          Expanded(
            child: Center(
              child:
                  authState is AuthLoading
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
                              padding: const EdgeInsets.all(16),
                              child: Form(
                                key: _formKey,
                                child: AutofillGroup(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(8),
                                            child: AppTitle(
                                              prefix: 'Dołącz do ',
                                              useGradient: true,
                                              fontSize: 29,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Stwórz konto i odkryj świat wiedzy!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 32),

                                      if (authState is AuthFailure)
                                        Text(authState.message),

                                      _buildRegistrationForm(),

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
                                        child: const Text('Przejdź dalej'),
                                      ),

                                      const SizedBox(height: 12),
                                      TextButton(
                                        onPressed:
                                            authState is AuthLoading
                                                ? null
                                                : () {
                                                  _resetFormState();
                                                  context.replace('/login');
                                                },
                                        child: const Text(
                                          'Masz już konto? Zaloguj się.',
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
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthFormFieldFactory.createEmailField(
          context: context,
          ref: ref,
          controller: _emailController,
          fieldName: _emailField,
          label: 'Adres e-mail',
          focusNode: _emailFocusNode,
          manageErrorTextManually: true,
          autofillHints: const [AutofillHints.email],
          onFieldSubmitted:
              (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
          //textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        AuthFormFieldFactory.createPasswordField(
          context: context,
          ref: ref,
          controller: _passwordController,
          fieldName: _passwordField,
          label: 'Hasło',
          focusNode: _passwordFocusNode,
          visibilityProvider: registerPasswordVisibilityProvider,
          manageErrorTextManually: false,
          enableStrengthIndicator: true,
          autofillHints: const [AutofillHints.newPassword],
          onFieldSubmitted:
              (_) => FocusScope.of(
                context,
              ).requestFocus(_passwordConfirmationFocusNode),
          //textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        AuthFormFieldFactory.createPasswordField(
          context: context,
          ref: ref,
          controller: _passwordConfirmationController,
          fieldName: _passwordConfirmField,
          label: 'Potwierdź hasło',
          focusNode: _passwordConfirmationFocusNode,
          visibilityProvider: confirmPasswordVisibilityProvider,
          manageErrorTextManually: false,
          autofillHints: const [AutofillHints.newPassword],
          customValidator: (value) {
            // Niestandardowy walidator dla tego pola
            if (value == null || value.isEmpty) {
              return 'Potwierdź hasło';
            }
            if (value != _passwordController.text) {
              return 'Hasła nie są zgodne';
            }
            return null;
          },
          onFieldSubmitted: (_) => _submitForm(),
        ),
      ],
    );
  }
}
