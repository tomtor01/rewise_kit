import '../utils/typedefs.dart';

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  FutureResult<T> call(Params params);
}

abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();

  FutureResult<T> call();
}
