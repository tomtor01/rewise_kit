import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';

class AuthGate extends ConsumerStatefulWidget {
  final bool initialShowLoginScreen;
  const AuthGate({super.key, this.initialShowLoginScreen = false});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> {
  late bool _showLoginScreen;

  @override
  void initState() {
    super.initState();
    _showLoginScreen = widget.initialShowLoginScreen;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          // Jeśli użytkownik się zalogował
          if (user != null) {
            // Migruje dane lokalne do Firestore
            // WidgetsBinding.instance.addPostFrameCallback((_) async {
            //   final repository = ref.read(notesRepositoryProvider);
            //   await repository.migrateLocalToFirestore();
            //   ref.invalidate(notesProvider); // Odświeża listę notatek
            // });
            _showLoginScreen = false;
          }
        }
        if (_showLoginScreen) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.of(context).pop();
              }),
              AuthStateChangeAction<UserCreated>((context, state) {
                Navigator.of(context).pop();
              }),
            ],
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Witaj w aplikacji Notatki, zaloguj się!')
                    : const Text('Witaj w aplikacji Notatki, zarejestruj się!'),
              );
            },
            footerBuilder: (context, action) {
              return Column(
                children: [
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showLoginScreen = false;
                      });
                    },
                    child: const Text('Kontynuuj bez logowania'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Logując się, akceptujesz warunki korzystania z aplikacji.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              );
            },
          );
        }
        return const HomePage();
      },
    );
  }
}