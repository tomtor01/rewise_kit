import 'package:flutter/material.dart';
import '../../../../core/common/app/cache/cache.dart';
import '../../../../core/common/app/cache/cache_helper.dart';
import '../../../../core/services/injection_container.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 128),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ValueListenableBuilder<ThemeMode>(
              valueListenable: Cache.instance.themeModeNotifier,
              builder: (_, mode, _) {
                return DropdownButtonFormField<ThemeMode>(
                  value: mode,
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
                  onChanged: (newMode) {
                    if (newMode != null) {
                      sl<CacheHelper>().cacheThemeMode(newMode);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}