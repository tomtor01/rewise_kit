import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rewise_kit/features/auth/application/adapters/auth_adapter.dart';
import 'package:rewise_kit/features/auth/presentation/screens/register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginUser() {
    if (_formKey.currentState!.validate()) {
      ref.read(authAdapterProvider.notifier).signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nasłuchuj na zmiany stanu, aby pokazać np. SnackBar w razie błędu.
    // AuthGate zajmie się nawigacją po udanym logowaniu.
    ref.listen<AuthState>(authAdapterProvider, (previous, next) {
      if (next is AuthFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    // Obserwuj stan, aby wiedzieć, czy pokazać wskaźnik ładowania.
    final authState = ref.watch(authAdapterProvider);
    final isLoading = authState is AuthLoading;

    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Zaloguj się', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: loginUser,
                    child: const Text('Zaloguj'),
                  ),
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ));
                  },
                  child: const Text('Nie masz konta? Zarejestruj się'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}