import 'package:equatable/equatable.dart';

class CacheException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const CacheException({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
