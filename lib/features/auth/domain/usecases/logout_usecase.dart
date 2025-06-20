import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase extends UseCaseWithoutParams<void> {
  final AuthRepository _repository;

  const LogoutUseCase(this._repository);

  @override
  FutureResult<void> call() => _repository.logoutUser();
}
