import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/flashcard.dart';

class FlashcardModel extends Flashcard {
  const FlashcardModel({
    required super.id,
    required super.flashcardSetId,
    required super.front,
    required super.back,
    required super.createdAt,
    super.lastReviewedAt,
  });

  factory FlashcardModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return FlashcardModel(
      id: doc.id,
      flashcardSetId: data['flashcardSetId'] ?? '',
      front: data['front'] ?? '',
      back: data['back'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastReviewedAt:
          data['lastReviewedAt'] != null
              ? (data['lastReviewedAt'] as Timestamp).toDate()
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'flashcardSetId': flashcardSetId,
      'front': front,
      'back': back,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastReviewedAt':
          lastReviewedAt != null ? Timestamp.fromDate(lastReviewedAt!) : null,
    };
  }

  factory FlashcardModel.fromEntity(Flashcard entity) {
    return FlashcardModel(
      id: entity.id,
      flashcardSetId: entity.flashcardSetId,
      createdAt: entity.createdAt,
      front: entity.front,
      back: entity.back,
    );
  }

  Flashcard toEntity() {
    return Flashcard(
      id: id,
      flashcardSetId: flashcardSetId,
      createdAt: createdAt,
      front: front,
      back: back,
    );
  }
}
