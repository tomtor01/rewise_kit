import 'package:equatable/equatable.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase extends UseCaseWithParams<void, RegisterParams> {
  final AuthRepository _repository;

  const SignUpUseCase(this._repository);

  @override
  FutureResult<User> call(RegisterParams params) => _repository.registerUser(
    email: params.email,
    password: params.password,
    passwordConfirmation: params.password,
  );
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String passwordConfirmation;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  const RegisterParams.empty()
    : email = '',
      password = '',
      passwordConfirmation = '';

  @override
  List<Object?> get props => [email, password, passwordConfirmation];
}
