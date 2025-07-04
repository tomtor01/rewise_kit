import 'package:equatable/equatable.dart';

class FlashcardSet extends Equatable {
  final String id;
  final String lessonId;
  final String title;
  final String description;
  final DateTime createdAt;
  final int flashcardCount;

  const FlashcardSet({
    required this.id,
    required this.lessonId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.flashcardCount,
  });

  @override
  List<Object?> get props => [
    id,
    lessonId,
    title,
    description,
    createdAt,
    flashcardCount,
  ];
}
