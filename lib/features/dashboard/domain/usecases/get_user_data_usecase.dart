import 'package:equatable/equatable.dart';

import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../../../dashboard/domain/entities/user_data.dart';
import '../repositories/dashboard_repository.dart';

class GetUserDataUseCase
    extends UseCaseWithParams<UserData, GetUserDataParams> {
  final DashboardRepository _repository;

  GetUserDataUseCase(this._repository);

  @override
  FutureResult<UserData> call(GetUserDataParams params) async =>
      _repository.getUserData(userId: params.userId);
}

class GetUserDataParams extends Equatable {
  final String userId;

  const GetUserDataParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
