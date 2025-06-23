part of 'router.dart';

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;
    final bool loggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';

    if (!loggedIn) {
      // Jeśli użytkownik nie jest zalogowany, może iść tylko do /login lub /register
      return loggingIn ? null : '/login';
    }

    // Jeśli użytkownik jest zalogowany i próbuje wejść na /login lub /register, przekieruj go do strony głównej
    if (loggingIn) {
      return '/';
    }

    // W przeciwnym razie nie ma potrzeby przekierowania
    return null;
  },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return RootNavigator(navigationShell: navigationShell);
      },
      branches: [
        // Trasy główne
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomePage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return ProfileScreen(
          appBar: AppBar(
            title: const Text('Twój profil'),
          ),
          actions: [
            SignedOutAction((context) {
              // Po wylogowaniu, zdejmij ekran profilu ze stosu,
              // aby wrócić do poprzedniego widoku.
              context.pop();
            })
          ],
        );
      },
    ),
  ],
);
