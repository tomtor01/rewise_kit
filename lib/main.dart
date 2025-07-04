import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/common/app/cache/cache.dart';
import 'core/route/router.dart';
import 'core/services/injection_container.dart';
import 'core/theme/theme.dart';
import 'core/theme/util.dart';
import 'features/auth/presentation/app/providers/firebase_auth_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  final container = ProviderContainer();
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    // i inne jesli dodam
  ]);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  container.read(authServiceProvider);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Lato", "Alegreya");
    MaterialTheme theme = MaterialTheme(textTheme);
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: Cache.instance.themeModeNotifier,
      builder: (_, mode, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'ReWiseKit',
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: mode,
          routerConfig: router,
        );
      },
    );
  }
}
