import 'package:equatable/equatable.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../entities/flashcard.dart';
import '../repositories/flashcard_repository.dart';

class GetFlashcardsByLessonIdUseCase
    extends UseCaseWithParams<List<Flashcard>, GetFlashcardsByLessonIdParams> {
  final FlashcardRepository _repository;

  GetFlashcardsByLessonIdUseCase(this._repository);

  @override
  FutureResult<List<Flashcard>> call(GetFlashcardsByLessonIdParams params) =>
      _repository.getFlashcardsByLessonId(lessonId: params.lessonId);
}

class GetFlashcardsByLessonIdParams extends Equatable {
  final String lessonId;

  const GetFlashcardsByLessonIdParams({required this.lessonId});

  @override
  List<Object?> get props => [lessonId];
}