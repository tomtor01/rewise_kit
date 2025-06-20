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

final class UserSignedUp extends AuthState {
  const UserSignedUp();
}

final class UserSignedIn extends AuthState {
  const UserSignedIn();
}

final class UserSignedOut extends AuthState {
  const UserSignedOut();
}
