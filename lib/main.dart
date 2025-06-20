import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/common/app/cache/cache.dart';
import 'core/services/injection_container.dart';
import 'core/theme/theme.dart';
import 'core/theme/util.dart';
import 'features/auth/presentation/screens/auth_gate.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Lato", "Acme");
    MaterialTheme theme = MaterialTheme(textTheme);
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: Cache.instance.themeModeNotifier,
      builder: (_, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ReWiseKit',
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: mode,
          home: const AuthGate(),
        );
      },
    );
  }
}
