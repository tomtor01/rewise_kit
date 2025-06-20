import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/injection_container.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

part '../state/auth_state.dart';

part 'auth_adapter.g.dart';

@riverpod
class AuthAdapter extends _$AuthAdapter {
  @override
  AuthState build() {
    _signInUseCase = sl<SignInUseCase>();
    _signUpUseCase = sl<SignUpUseCase>();
    _logoutUseCase = sl<LogoutUseCase>();

    return const AuthInitial();
  }

  late SignInUseCase _signInUseCase;
  late SignUpUseCase _signUpUseCase;
  late LogoutUseCase _logoutUseCase;

  Future<void> signIn(String email, String password) async {
    state = const AuthLoading();
    final result = await _signInUseCase(
      LoginParams(email: email, password: password),
    );
    result.fold(
      (failure) => state = AuthFailure(failure.message),
      (_) => state = const UserSignedIn(),
    );
  }

  Future<void> signUp(String email, String password) async {
    state = const AuthLoading();
    final result = await _signUpUseCase(
      RegisterParams(
        email: email,
        password: password,
        passwordConfirmation: password,
      ),
    );
    result.fold(
      (failure) => state = AuthFailure(failure.message),
      (_) => state = const UserSignedUp(),
    );
  }
  Future<void> logout() async {
    state = const AuthLoading();
    final result = await _logoutUseCase();
    result.fold(
          (failure) => state = AuthFailure(failure.message),
          (_) => state = const UserSignedOut(),
    );
  }
}
