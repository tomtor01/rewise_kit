import 'package:equatable/equatable.dart';

import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/lesson_repository.dart';

class SaveLessonUseCase extends UseCaseWithParams<void, SaveLessonParams> {
  final LessonRepository _repository;

  SaveLessonUseCase(this._repository);

  @override
  FutureResult<void> call(SaveLessonParams params) async =>
      _repository.saveLesson(lessonId: params.lessonId);
}

class SaveLessonParams extends Equatable {
  final String lessonId;

  const SaveLessonParams({required this.lessonId});

  @override
  List<Object?> get props => [lessonId];
}
