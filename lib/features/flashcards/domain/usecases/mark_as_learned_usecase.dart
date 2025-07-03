import 'package:equatable/equatable.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/flashcard_repository.dart';

class MarkAsLearnedUseCase
    extends UseCaseWithParams<void, MarkAsLearnedParams> {
  final FlashcardRepository _repository;

  MarkAsLearnedUseCase(this._repository);

  @override
  FutureResult<void> call(MarkAsLearnedParams params) =>
      _repository.markAsLearned(flashcardId: params.flashcardId);
}

class MarkAsLearnedParams extends Equatable {
  final String flashcardId;

  const MarkAsLearnedParams({required this.flashcardId});

  @override
  List<Object?> get props => [flashcardId];
}
