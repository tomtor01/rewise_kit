import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rewise_kit/features/auth/application/adapters/auth_adapter.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void registerUser() {
    if (_formKey.currentState!.validate()) {
      ref.read(authAdapterProvider.notifier).signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nasłuchuj na zmiany stanu. Po udanej rejestracji wróć do ekranu logowania.
    // W przypadku błędu, pokaż SnackBar.
    ref.listen<AuthState>(authAdapterProvider, (previous, next) {
      if (next is AuthFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
      // Po udanej rejestracji, AuthGate przeniesie do HomePage.
      // Tutaj wracamy do poprzedniego ekranu (prawdopodobnie LoginScreen).
      if (next is UserSignedUp) {
        if (mounted) Navigator.of(context).pop();
      }
    });

    final authState = ref.watch(authAdapterProvider);
    final isLoading = authState is AuthLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Rejestracja')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) =>
                  value!.isEmpty ? 'Wprowadź email' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Hasło'),
                  obscureText: true,
                  validator: (value) =>
                  value!.isEmpty ? 'Wprowadź hasło' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration:
                  const InputDecoration(labelText: 'Potwierdź hasło'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) return 'Potwierdź hasło';
                    if (value != _passwordController.text) {
                      return 'Hasła nie są zgodne';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: registerUser,
                    child: const Text('Zarejestruj'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}