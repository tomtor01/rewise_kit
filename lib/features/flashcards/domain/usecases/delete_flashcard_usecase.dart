import 'package:equatable/equatable.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/flashcard_repository.dart';

class DeleteFlashcardUseCase
    extends UseCaseWithParams<void, DeleteFlashcardParams> {
  final FlashcardRepository _repository;

  DeleteFlashcardUseCase(this._repository);

  @override
  FutureResult<void> call(DeleteFlashcardParams params) =>
      _repository.deleteFlashcard(flashcardId: params.flashcardId);
}

class DeleteFlashcardParams extends Equatable {
  final String flashcardId;

  const DeleteFlashcardParams({required this.flashcardId});

  @override
  List<Object?> get props => [flashcardId];
}
