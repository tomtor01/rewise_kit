import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rewise_kit/features/auth/presentation/screens/login_screen.dart';

import 'home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Użytkownik jest zalogowany
        if (snapshot.hasData) {
          return const HomePage();
        }
        // Użytkownik nie jest zalogowany
        return const LoginScreen();
      },
    );
  }
}