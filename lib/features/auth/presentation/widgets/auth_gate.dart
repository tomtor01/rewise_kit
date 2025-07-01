import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/providers/firebase_auth_provider.dart';
import '../../../lessons/presentation/screens/home_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ten plik nie definiuje już providera, tylko go konsumuje
    final authState = ref.watch(firebaseAuthStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomePage();
        }
        return SignInScreen(
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {}),
            AuthStateChangeAction<UserCreated>((context, state) {}),
          ],
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Błąd: $err'))),
    );
  }
}