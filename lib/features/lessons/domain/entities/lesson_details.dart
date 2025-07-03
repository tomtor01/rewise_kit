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

  LessonDetails copyWith({
    List<Flashcard>? content,
  }) {
    return LessonDetails(
      id: id,
      title: title,
      description: description,
      creatorId: creatorId,
      createdAt: createdAt,
      content: content ?? this.content,
    );
  }
}