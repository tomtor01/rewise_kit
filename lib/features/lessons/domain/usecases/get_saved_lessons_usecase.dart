import 'package:equatable/equatable.dart';

import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../entities/lesson.dart';
import '../repositories/lesson_repository.dart';

class GetSavedLessonsUseCase
    extends UseCaseWithParams<List<Lesson>, GetSavedLessonsParams> {
  final LessonRepository _repository;

  const GetSavedLessonsUseCase(this._repository);

  @override
  FutureResult<List<Lesson>> call(GetSavedLessonsParams params) =>
      _repository.getSavedLessons(lessonIds: params.lessonIds);
}

class GetSavedLessonsParams extends Equatable {
  final List<String> lessonIds;

  const GetSavedLessonsParams({required this.lessonIds});

  @override
  List<Object?> get props => [lessonIds];
}
