import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/responsive_layout.dart';

class RootNavigator extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const RootNavigator({super.key, required this.navigationShell});

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.book_outlined),
      selectedIcon: Icon(Icons.book),
      label: 'Lekcje',
    ),
    NavigationDestination(
      icon: Icon(Icons.bookmark_border),
      selectedIcon: Icon(Icons.bookmark),
      label: 'Zasoby',
    ),
    NavigationDestination(
      icon: Icon(Icons.manage_accounts_outlined),
      selectedIcon: Icon(Icons.manage_accounts),
      label: 'Ustawienia',
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return AdaptiveScaffoldWithNavigation(
      destinations: _destinations,
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      drawerActions: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Stwórz zespół'),
      ),
      child: navigationShell,
    );
  }
}