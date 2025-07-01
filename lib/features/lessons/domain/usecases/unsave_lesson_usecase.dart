import 'package:equatable/equatable.dart';

import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/lesson_repository.dart';

class UnsaveLessonUseCase extends UseCaseWithParams<void, UnsaveLessonParams> {
  final LessonRepository _repository;

  UnsaveLessonUseCase(this._repository);

  @override
  FutureResult<void> call(UnsaveLessonParams params) async =>
      _repository.unsaveLesson(lessonId: params.lessonId);
}

class UnsaveLessonParams extends Equatable {
  final String lessonId;

  const UnsaveLessonParams({required this.lessonId});

  @override
  List<Object?> get props => [lessonId];
}
