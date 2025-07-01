import 'package:rewise_kit/features/lessons/domain/entities/lesson.dart';

import '../../../flashcards/domain/entities/flashcard.dart';

class LessonDetails extends Lesson {
  final List<Flashcard> content;

  const LessonDetails({
    required super.id,
    required super.title,
    required super.description,
    required super.creatorId,
    required super.createdAt,
    required this.content,
  });

// Możesz dodać metodę copyWith, jeśli będzie potrzebna
}