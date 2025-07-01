import 'package:equatable/equatable.dart';

import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../entities/lesson.dart';
import '../repositories/lesson_repository.dart';

class GetCreatedLessonsUseCase
    extends UseCaseWithParams<List<Lesson>, GetCreatedLessonsParams> {
  final LessonRepository _repository;

  const GetCreatedLessonsUseCase(this._repository);

  @override
  FutureResult<List<Lesson>> call(GetCreatedLessonsParams params) =>
      _repository.getCreatedLessons(creatorId: params.creatorId);
}

class GetCreatedLessonsParams extends Equatable {
  final String creatorId;

  const GetCreatedLessonsParams({required this.creatorId});

  @override
  List<Object?> get props => [creatorId];
}