import 'package:dartz/dartz.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/common/error/exceptions.dart';
import '../../../../core/common/error/failures.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImpl(this._remoteDataSource);

  @override
  FutureResult<User> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remoteDataSource.loginUser(
        email: email,
        password: password,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  FutureResult<void> logoutUser() async {
    try {
      await _remoteDataSource.logoutUser();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  FutureResult<User> registerUser({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      if (password != passwordConfirmation) {
        return const Left(
          ServerFailure(message: 'Passwords do not match', statusCode: 400),
        );
      }
      final user = await _remoteDataSource.registerUser(
        email: email,
        password: password,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
