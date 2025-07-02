import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/main_app_bar.dart';
import '../../../../core/widgets/responsive_layout.dart';

/// widget, który układa MainAppBar i TabBar jeden nad drugim.
/// Implementuje PreferredSizeWidget, aby można go było użyć w `appBar` w Scaffold.
class HomePageHeader extends StatelessWidget implements PreferredSizeWidget {
  final WindowSizeClass windowSizeClass;
  final List<Widget>? actions;
  final TabController tabController;
  final List<Tab> tabs;

  const HomePageHeader({
    super.key,
    required this.windowSizeClass,
    this.actions,
    required this.tabController,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      elevation: 2.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MainAppBar(
            windowSizeClass: windowSizeClass,
            leadingActions: actions,
          ),
            TabBar(
              controller: tabController,
              labelStyle: GoogleFonts.workSans(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              unselectedLabelStyle: GoogleFonts.workSans(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              unselectedLabelColor: Theme.of(
                context,
              ).colorScheme.onSurface.withAlpha(178),
              indicatorWeight: 3,
              tabs: const [Tab(text: 'Utworzone'), Tab(text: 'Zapisane')],
            ),
        ],
      ),
    );
  }

  // Całkowita wysokość nagłówka to suma wysokości AppBar i TabBar
  @override
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight + kTextTabBarHeight + 1.0 );
}
