import '../../../../core/common/entities/user.dart';
import '../../../../core/common/utils/typedefs.dart';

abstract class AuthRepository {
  const AuthRepository();

  FutureResult<User> registerUser({
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  FutureResult<User> loginUser({
    required String email,
    required String password,
  });

  FutureResult<void> logoutUser();
}
