import 'package:equatable/equatable.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/flashcard_repository.dart';

class UpdateFlashcardUseCase
    extends UseCaseWithParams<void, UpdateFlashcardParams> {
  final FlashcardRepository _repository;

  UpdateFlashcardUseCase(this._repository);

  @override
  FutureResult<void> call(UpdateFlashcardParams params) =>
      _repository.updateFlashcard(
        flashcardId: params.flashcardId,
        front: params.front,
        back: params.back,
      );
}

class UpdateFlashcardParams extends Equatable {
  final String flashcardId;
  final String front;
  final String back;

  const UpdateFlashcardParams({
    required this.flashcardId,
    required this.front,
    required this.back,
  });

  @override
  List<Object?> get props => [flashcardId, front, back];
}
