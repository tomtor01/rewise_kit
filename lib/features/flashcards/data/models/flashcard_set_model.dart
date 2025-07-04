import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/flashcard_set.dart';

class FlashcardSetModel extends FlashcardSet {
  const FlashcardSetModel({
    required super.id,
    required super.title,
    required super.description,
    required super.lessonId,
    required super.createdAt,
    required super.flashcardCount,
  });

  factory FlashcardSetModel.fromMap(Map<String, dynamic> map, [String? documentId]) {
    return FlashcardSetModel(
      id: map['id'] as String? ?? documentId ?? '',
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      lessonId: map['lessonId'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      flashcardCount: map['flashcardCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'lessonId': lessonId,
      'createdAt': Timestamp.fromDate(createdAt),
      'flashcardCount': flashcardCount,
    };
  }

  factory FlashcardSetModel.fromEntity(FlashcardSet entity) {
    return FlashcardSetModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      lessonId: entity.lessonId,
      createdAt: entity.createdAt,
      flashcardCount: entity.flashcardCount,
    );
  }

  FlashcardSet toEntity() {
    return FlashcardSet(
      id: id,
      title: title,
      description: description,
      lessonId: lessonId,
      createdAt: createdAt,
      flashcardCount: flashcardCount,
    );
  }
}