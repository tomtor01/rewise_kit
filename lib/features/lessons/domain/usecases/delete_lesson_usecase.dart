import 'package:equatable/equatable.dart';
import 'package:rewise_kit/core/common/usecase/usecase.dart';
import 'package:rewise_kit/core/common/utils/typedefs.dart';

import '../repositories/lesson_repository.dart';

class DeleteLessonUseCase extends UseCaseWithParams<void, DeleteLessonParams> {
  final LessonRepository _repository;

  DeleteLessonUseCase(this._repository);

  @override
  FutureResult<void> call(DeleteLessonParams params) =>
      _repository.deleteLesson(lessonId: params.lessonId);
}

class DeleteLessonParams extends Equatable {
  final String lessonId;

  const DeleteLessonParams({required this.lessonId});

  @override
  List<Object?> get props => [lessonId];
}
