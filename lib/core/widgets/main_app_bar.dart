import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rewise_kit/core/widgets/responsive_layout.dart';

import '../common/providers/current_user_provider.dart';
import 'app_title.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final WindowSizeClass windowSizeClass;
  final bool isGuest;

  const MainAppBar({
    super.key,
    required this.windowSizeClass,
    this.isGuest = false,
  });

  @override
  Widget build(BuildContext context) {
    final double titlePadding =
        windowSizeClass == WindowSizeClass.compact ? 0 : 64.0;
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(left: titlePadding),
        child: const AppTitle(),
      ),
      actions: [
        if (!isGuest)
          Consumer(
            builder: (context, ref, _) {
              final user = ref.watch(currentUserProvider);
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () {
                    if (user != null) {
                      context.push('/profile');
                    } else {
                      context.push('/login');
                    }
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        user != null
                            ? Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.purpleAccent,
                                    Colors.blueAccent,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  (user.name ?? user.email!).length >= 2
                                      ? (user.name ?? user.email!).substring(
                                        0,
                                        2,
                                      )
                                      : (user.name ?? user.email!),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                            : Icon(
                              Icons.account_circle_outlined,
                              color: Theme.of(context).colorScheme.onSurface,
                              size: 28,
                            ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
