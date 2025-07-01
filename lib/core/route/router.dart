import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide RegisterScreen;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rewise_kit/core/route/root_navigation.dart';

import '../../features/lessons/presentation/screens/home_page.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/settings_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/lessons/presentation/screens/lesson_screen.dart';

part 'router.main.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}