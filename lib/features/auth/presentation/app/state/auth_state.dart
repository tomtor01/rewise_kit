part of '../adapters/auth_adapter.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

final class SignedUp extends AuthState {
  final User user;

  const SignedUp(this.user);
}

final class SignedIn extends AuthState {
  final User user;

  const SignedIn(this.user);
}

final class SignedOut extends AuthState {
  const SignedOut();
}
