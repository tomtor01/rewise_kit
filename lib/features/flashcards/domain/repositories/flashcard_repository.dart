import '../../../../core/common/utils/typedefs.dart';
import '../entities/flashcard.dart';
import '../entities/flashcard_set.dart';

abstract class FlashcardRepository {
  FutureResult<void> createFlashcard({
    required String flashcardSetId,
    required String front,
    required String back,
  });

  FutureResult<void> createFlashcardSet({
    required String lessonId,
    required String title,
    String? description,
  });

  FutureResult<List<Flashcard>> getFlashcardsBySetId({
    required String flashcardSetId,
  });

  FutureResult<void> updateFlashcard({
    required String flashcardId,
    required String front,
    required String back,
  });

  FutureResult<void> deleteFlashcard({
    required String flashcardId,
  });

  FutureResult<void> updateLastReviewed({
    required String flashcardId,
  });

  FutureResult<List<FlashcardSet>> getFlashcardSets({required String lessonId});
}