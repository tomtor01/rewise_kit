import 'package:equatable/equatable.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/flashcard_repository.dart';

class CreateFlashcardSetUseCase
    extends UseCaseWithParams<void, CreateFlashcardSetParams> {
  final FlashcardRepository _repository;

  CreateFlashcardSetUseCase(this._repository);

  @override
  FutureResult<void> call(CreateFlashcardSetParams params) =>
      _repository.createFlashcardSet(
        lessonId: params.lessonId,
        title: params.title,
        description: params.description,
      );
}

class CreateFlashcardSetParams extends Equatable {
  final String lessonId;
  final String title;
  final String description;

  const CreateFlashcardSetParams({
    required this.lessonId,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [lessonId, title, description];
}
