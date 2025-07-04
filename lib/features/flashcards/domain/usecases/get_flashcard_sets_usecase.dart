import 'package:equatable/equatable.dart';
import 'package:rewise_kit/core/common/usecase/usecase.dart';
import 'package:rewise_kit/core/common/utils/typedefs.dart';

import '../entities/flashcard_set.dart';
import '../repositories/flashcard_repository.dart';

class GetFlashcardSetsUseCase
    extends UseCaseWithParams<List<FlashcardSet>, GetFlashcardSetsParams> {
  final FlashcardRepository _repository;

  const GetFlashcardSetsUseCase(this._repository);

  @override
  FutureResult<List<FlashcardSet>> call(GetFlashcardSetsParams params) =>
      _repository.getFlashcardSets(lessonId: params.lessonId);
}

class GetFlashcardSetsParams extends Equatable {
  final String lessonId;

  const GetFlashcardSetsParams({required this.lessonId});

  @override
  List<Object?> get props => [lessonId];
}
