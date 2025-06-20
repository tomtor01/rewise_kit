import 'package:equatable/equatable.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase extends UseCaseWithParams<User, LoginParams> {
  final AuthRepository _repository;

  const SignInUseCase(this._repository);

  @override
  FutureResult<User> call(LoginParams params) =>
      _repository.loginUser(email: params.email, password: params.password);
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  const LoginParams.empty() : email = '', password = '';

  @override
  List<Object?> get props => [email, password];
}
