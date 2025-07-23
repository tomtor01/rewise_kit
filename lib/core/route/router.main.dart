part of 'router.dart';

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(
    FirebaseAuth.instance.authStateChanges(),
  ),
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;
    final bool loggingIn =
        state.matchedLocation == '/login' ||
        state.matchedLocation == '/register';

    if (!loggedIn) {
      return loggingIn ? null : '/login';
    }

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
      path: '/lesson/:lessonId',
      // Ważny klucz, aby trasa renderowała się na głównym nawigatorze
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final lessonId = state.pathParameters['lessonId']!;
        return LessonScreen(lessonId: lessonId);
      },
    ),
    GoRoute(
      path: '/lesson/:lessonId/flashcards',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final lessonId = state.pathParameters['lessonId']!;
        final isCreator = state.uri.queryParameters['isCreator'] == 'true';
        return FlashcardSetScreen(lessonId: lessonId, isCreator: isCreator);
      },
    ),
    GoRoute(
      path: '/lesson/:lessonId/flashcards/create',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final lessonId = state.pathParameters['lessonId']!;
        return FlashcardSetFormScreen(lessonId: lessonId);
      },
    ),
    GoRoute(
      path: '/flashcard-set/:setId/study',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final setId = state.pathParameters['setId']!;
        return FlashcardStudyScreen(flashcardSetId: setId);
      },
    ),
    GoRoute(
      path: '/flashcard-set/:setId/manage',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final setId = state.pathParameters['setId'];
        print('SetId: $setId'); // Debug

        if (setId == null) {
          return const Scaffold(body: Center(child: Text('Brak ID zestawu')));
        }

        return ManageFlashcardScreen(flashcardSetId: setId);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return ProfileScreen(appBar: AppBar(title: const Text('Twój profil')));
      },
    ),
  ],
);
