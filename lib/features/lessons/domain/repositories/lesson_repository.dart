import 'package:rewise_kit/core/common/utils/typedefs.dart';
import '../entities/lesson.dart';
import '../entities/lesson_details.dart';

abstract class LessonRepository {
  FutureResult<void> createLesson({
    required String title,
    required String description,
  });

  FutureResult<List<Lesson>> getCreatedLessons({required String creatorId});

  FutureResult<List<Lesson>> searchLessons({required String query});

  FutureResult<LessonDetails> getLessonById({required String lessonId});

  FutureResult<void> saveLesson({required String lessonId});

  FutureResult<void> unsaveLesson({required String lessonId});

  FutureResult<List<Lesson>> getSavedLessons({required List<String> lessonIds});

  FutureResult<void> deleteLesson({required String lessonId});
}
