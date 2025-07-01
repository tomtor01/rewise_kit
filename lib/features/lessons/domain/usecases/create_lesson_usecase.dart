import 'package:equatable/equatable.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/lesson_repository.dart';

class CreateLessonUseCase extends UseCaseWithParams<void, CreateLessonParams> {
  final LessonRepository _repository;

  CreateLessonUseCase(this._repository);

  @override
  FutureResult<void> call(CreateLessonParams params) => _repository
      .createLesson(title: params.title, description: params.description);
}

class CreateLessonParams extends Equatable {
  final String title;
  final String description;

  const CreateLessonParams({required this.title, required this.description});

  @override
  List<Object?> get props => [title, description];
}
