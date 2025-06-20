import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/theme/util.dart';
import 'features/auth/presentation/screens/auth_gate.dart';
import 'firebase_options.dart';

final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) => ThemeProvider());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextTheme textTheme = createTextTheme(context, "Lato", "Acme");
    MaterialTheme theme = MaterialTheme(textTheme);
    final themeMode = ref.watch(themeProvider).themeMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prosty notatnik',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: themeMode,
      home: const AuthGate(),
    );
  }
}