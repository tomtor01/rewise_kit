import 'package:equatable/equatable.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../entities/flashcard.dart';
import '../repositories/flashcard_repository.dart';

class GetFlashcardsBySetIdUseCase
    extends UseCaseWithParams<List<Flashcard>, GetFlashcardsBySetIdParams> {
  final FlashcardRepository _repository;

  GetFlashcardsBySetIdUseCase(this._repository);

  @override
  FutureResult<List<Flashcard>> call(GetFlashcardsBySetIdParams params) =>
      _repository.getFlashcardsBySetId(flashcardSetId: params.flashcardSetId);
}

class GetFlashcardsBySetIdParams extends Equatable {
  final String flashcardSetId;

  const GetFlashcardsBySetIdParams({required this.flashcardSetId});

  @override
  List<Object?> get props => [flashcardSetId];
}