import 'package:equatable/equatable.dart';
import 'package:rewise_kit/core/common/utils/typedefs.dart';

import '../../../../core/common/usecase/usecase.dart';
import '../repositories/flashcard_repository.dart';

class DeleteFlashcardSetUseCase
    extends UseCaseWithParams<void, DeleteFlashcardSetParams> {
  final FlashcardRepository _repository;

  DeleteFlashcardSetUseCase(this._repository);

  @override
  FutureResult<void> call(DeleteFlashcardSetParams params) =>
      _repository.deleteFlashcardSet(flashcardSetId: params.setId);
}

class DeleteFlashcardSetParams extends Equatable {
  final String setId;

  const DeleteFlashcardSetParams({required this.setId});

  @override
  List<Object?> get props => [setId];
}
