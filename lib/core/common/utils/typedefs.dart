import 'package:dartz/dartz.dart';

import '../error/failures.dart';

typedef FutureResult<T> = Future<Either<Failure, T>>;
