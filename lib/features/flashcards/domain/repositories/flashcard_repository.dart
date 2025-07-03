import 'package:rewise_kit/core/common/utils/typedefs.dart';
import '../entities/flashcard.dart';

abstract class FlashcardRepository {
  FutureResult<void> createFlashcard({
    required String lessonId,
    required String front,
    required String back,
  });

  FutureResult<List<Flashcard>> getFlashcardsByLessonId({
    required String lessonId,
  });

  FutureResult<void> updateFlashcard({
    required String flashcardId,
    required String front,
    required String back,
  });

  FutureResult<void> deleteFlashcard({required String flashcardId});

  FutureResult<void> markAsLearned({required String flashcardId});

  FutureResult<void> markAsNotLearned({required String flashcardId});
}