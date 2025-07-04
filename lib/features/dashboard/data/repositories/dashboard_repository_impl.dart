import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rewise_kit/features/dashboard/domain/entities/user_data.dart';

import '../../../../core/common/error/failures.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  final FirebaseAuth auth;

  DashboardRepositoryImpl(this.remoteDataSource, this.auth);

  @override
  FutureResult<UserData> getUserData({required String userId}) async {
    try {
      //final user = auth.currentUser;
      //if (user == null) return Left(ServerFailure(message: 'Użytkownik niezalogowany', statusCode: 401));
      final userData = await remoteDataSource.getUserData(userId);
      return Right(userData);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<void> markFlashcard({
    required String flashcardId,
    required bool isLearned,
  }) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return const Left(
          ServerFailure(message: 'User not logged in', statusCode: 401),
        );
      }

      await remoteDataSource.markFlashcard(
        userId: user.uid,
        flashcardId: flashcardId,
        isLearned: isLearned,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }
}