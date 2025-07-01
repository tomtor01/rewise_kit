import 'package:dartz/dartz.dart';
import 'package:rewise_kit/features/dashboard/domain/entities/user_data.dart';

import '../../../../core/common/error/failures.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;
  //final FirebaseAuth auth;

  DashboardRepositoryImpl(this.remoteDataSource);

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
}