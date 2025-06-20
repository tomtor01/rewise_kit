import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../main.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 128),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<ThemeMode>(
              value: theme.themeMode,
              decoration: const InputDecoration(
                labelText: 'Tryb motywu',
                border: OutlineInputBorder(),
              ),

              items: const [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Jasny'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Ciemny'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('Systemowy'),
                ),
              ],
              onChanged: (mode) {
                if (mode != null) {
                  ref.read(themeProvider).setTheme(mode);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}