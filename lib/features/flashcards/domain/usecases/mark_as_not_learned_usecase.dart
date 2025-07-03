import 'package:equatable/equatable.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/flashcard_repository.dart';

class MarkAsNotLearnedUseCase
    extends UseCaseWithParams<void, MarkAsNotLearnedParams> {
  final FlashcardRepository _repository;

  MarkAsNotLearnedUseCase(this._repository);

  @override
  FutureResult<void> call(MarkAsNotLearnedParams params) =>
      _repository.markAsNotLearned(flashcardId: params.flashcardId);
}

class MarkAsNotLearnedParams extends Equatable {
  final String flashcardId;

  const MarkAsNotLearnedParams({required this.flashcardId});

  @override
  List<Object?> get props => [flashcardId];
}
