import 'package:rewise_kit/core/common/utils/typedefs.dart';
import '../entities/lesson.dart';

abstract class LessonRepository {
  FutureResult<void> createLesson({
    required String title,
    required String description,
  });

  FutureResult<List<Lesson>> getLessons();
}
