import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rewise_kit/core/common/providers/current_user_provider.dart';
import 'package:rewise_kit/features/auth/data/models/user_model.dart';

import '../../presentation/app/providers/firebase_auth_provider.dart';

class AuthService {
  final Ref _ref;

  AuthService(this._ref);

  void init() {
    _ref.listen<AsyncValue<User?>>(firebaseAuthStateProvider, (previous, next) {
      if (next.isLoading) return;

      final firebaseUser = next.valueOrNull;
      if (firebaseUser != null) {
        final appUser = UserModel.fromFirebaseUser(firebaseUser);
        _ref.read(currentUserProvider.notifier).setUser(appUser);
      } else {
        _ref.read(currentUserProvider.notifier).clearUser();
      }
    });
  }
}
