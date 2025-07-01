import 'package:equatable/equatable.dart';

import 'exceptions.dart';

sealed class Failure extends Equatable {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  String get errorMessage => message;

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  final String? code;

  const ServerFailure({
    required super.message,
    required super.statusCode,
    this.code,
  });

  @override
  List<Object?> get props => [message, statusCode, code];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});

  CacheFailure.fromException(CacheException e)
      : this(
    message: e.message,
    statusCode: e.statusCode,
  );
}