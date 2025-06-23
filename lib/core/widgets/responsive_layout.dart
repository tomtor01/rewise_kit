import 'package:flutter/material.dart';
import 'package:rewise_kit/core/widgets/main_app_bar.dart';

enum WindowSizeClass {
  compact, // < 600px szerokości
  medium, // 600px - 840px szerokości
  large, // 840px - 1200px szerokości
  expanded, // > 1200px szerokości
}

// Klasa pomocnicza do określania klasy rozmiaru okna
class ResponsiveLayout {
  static const double _compactMaxWidth = 600;
  static const double _mediumMaxWidth = 840;
  static const double _largeMaxWidth = 1200;

  // Określa aktualną klasę rozmiaru okna na podstawie szerokości
  static WindowSizeClass getWindowSizeClass(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < _compactMaxWidth) {
      return WindowSizeClass.compact;
    } else if (width < _mediumMaxWidth) {
      return WindowSizeClass.medium;
    } else if (width < _largeMaxWidth) {
      return WindowSizeClass.large;
    } else {
      return WindowSizeClass.expanded;
    }
  }

  // Określa czy urządzenie jest w orientacji poziomej
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Zwraca liczbę kolumn dla siatki w zależności od klasy rozmiaru
  static int getGridColumnCount(WindowSizeClass windowSizeClass) {
    switch (windowSizeClass) {
      case WindowSizeClass.compact:
        return 1;
      case WindowSizeClass.medium:
        return 2;
      case WindowSizeClass.large:
        return 3;
      case WindowSizeClass.expanded:
        return 4;
    }
  }

  // Zwraca odpowiednie marginesy w zależności od klasy rozmiaru
  static EdgeInsets getMarginForWindowSize(WindowSizeClass windowSizeClass) {
    switch (windowSizeClass) {
      case WindowSizeClass.compact:
        return const EdgeInsets.all(16.0);
      case WindowSizeClass.medium:
        return const EdgeInsets.all(24.0);
      case WindowSizeClass.large:
        return const EdgeInsets.all(28.0);
      case WindowSizeClass.expanded:
        return const EdgeInsets.all(32.0);
    }
  }
}

// Widget, który renderuje różne widoki w zależności od klasy rozmiaru okna
class AdaptiveLayout extends StatelessWidget {
  final Widget compactLayout;
  final Widget mediumLayout;
  final Widget expandedLayout;
  final Widget? largeLayout;

  const AdaptiveLayout({
    super.key,
    required this.compactLayout,
    required this.mediumLayout,
    required this.expandedLayout,
    this.largeLayout,
  });

  @override
  Widget build(BuildContext context) {
    final windowSizeClass = ResponsiveLayout.getWindowSizeClass(context);

    switch (windowSizeClass) {
      case WindowSizeClass.compact:
        return compactLayout;
      case WindowSizeClass.medium:
        return mediumLayout;
      case WindowSizeClass.large:
        return largeLayout ?? expandedLayout;
      case WindowSizeClass.expanded:
        return expandedLayout;
    }
  }
}

// Widget dla adaptacyjnego układu z opcjonalnym panelem bocznym
class AdaptiveScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<NavigationDestination>? navigationDestinations;
  final int? selectedIndex;
  final ValueChanged<int>? onDestinationSelected;
  final FloatingActionButton? floatingActionButton;
  final List<Widget>? actions;

  const AdaptiveScaffold({
    super.key,
    this.title,
    required this.body,
    this.navigationDestinations,
    this.selectedIndex,
    this.onDestinationSelected,
    this.floatingActionButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final windowSizeClass = ResponsiveLayout.getWindowSizeClass(context);

    // Panel nawigacyjny widoczny tylko w trybie rozszerzonym (powyżej 1200px)
    final showSideNav =
        windowSizeClass == WindowSizeClass.expanded &&
        navigationDestinations != null;

    return Scaffold(
      appBar: (title) != null ? AppBar(
        title: Text(title!),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: actions,
        scrolledUnderElevation: 0,
      ) : null,
      body: SafeArea(
        child:
            showSideNav
                ? Row(
                  children: [
                    // Panel boczny
                    NavigationRail(
                      selectedIndex: selectedIndex ?? 0,
                      onDestinationSelected: onDestinationSelected ?? (_) {},
                      labelType: NavigationRailLabelType.all,
                      destinations:
                          navigationDestinations!
                              .map(
                                (destination) => NavigationRailDestination(
                                  icon: destination.icon,
                                  label: Text(destination.label),
                                ),
                              )
                              .toList(),
                    ),
                    // Separator
                    const VerticalDivider(thickness: 1, width: 1),
                    // Główna zawartość
                    Expanded(child: body),
                  ],
                )
                : body,
      ),
      // Dolny pasek nawigacji widoczny tylko w trybach kompaktowym, średnim i dużym
      bottomNavigationBar:
          showSideNav || navigationDestinations == null
              ? null
              : NavigationBar(
                selectedIndex: selectedIndex ?? 0,
                onDestinationSelected: onDestinationSelected ?? (_) {},
                destinations: navigationDestinations!,
              ),
      floatingActionButton: floatingActionButton,
    );
  }
}

class AdaptiveScaffoldWithNavigation extends StatelessWidget {
  final List<NavigationDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;
  final Widget? drawerActions;

  const AdaptiveScaffoldWithNavigation({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.child,
    this.drawerActions,
  });

  @override
  Widget build(BuildContext context) {
    final windowSizeClass = ResponsiveLayout.getWindowSizeClass(context);
    if (windowSizeClass != WindowSizeClass.compact) {
      // NavigationRail dla large
      return Scaffold(
        appBar: MainAppBar(windowSizeClass: windowSizeClass),
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              labelType: NavigationRailLabelType.selected,
              destinations:
              destinations
                  .map(
                    (d) => NavigationRailDestination(
                  icon: d.icon,
                  selectedIcon: d.selectedIcon,
                  label: Text(d.label),
                ),
              )
                  .toList(),
            ),
            Expanded(child: child),
          ],
        ),
      );
    } else {
      // NavigationBar dla mniejszych
      return Scaffold(
        appBar: MainAppBar(windowSizeClass: windowSizeClass),
        body: child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: destinations,
        ),
      );
    }
  }
}
