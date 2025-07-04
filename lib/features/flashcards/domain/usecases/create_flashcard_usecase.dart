import 'package:equatable/equatable.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/flashcard_repository.dart';

class CreateFlashcardUseCase
    extends UseCaseWithParams<void, CreateFlashcardParams> {
  final FlashcardRepository _repository;

  CreateFlashcardUseCase(this._repository);

  @override
  FutureResult<void> call(CreateFlashcardParams params) =>
      _repository.createFlashcard(
        flashcardSetId: params.flashcardSetId,
        front: params.front,
        back: params.back,
      );
}

class CreateFlashcardParams extends Equatable {
  final String flashcardSetId;
  final String front;
  final String back;

  const CreateFlashcardParams({
    required this.flashcardSetId,
    required this.front,
    required this.back,
  });

  @override
  List<Object?> get props => [flashcardSetId, front, back];
}
