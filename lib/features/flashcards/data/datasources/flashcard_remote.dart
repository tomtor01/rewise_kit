import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/flashcard.dart';
import '../models/flashcard_model.dart';

abstract class FlashcardRemoteDataSource {
  Future<void> createFlashcard({
    required String lessonId,
    required String flashcardSetId,
    required String front,
    required String back,
  });

  Future<void> createFlashcardSet({
    required String lessonId,
    required String title,
    required String description,
  });

  Future<List<Flashcard>> getFlashcardsBySetId({
    required String flashcardSetId,
  });

  Future<void> updateFlashcard({
    required String flashcardId,
    required String front,
    required String back,
  });

  Future<void> deleteFlashcard({
    required String flashcardId,
  });

  Future<void> updateLastReviewed({
    required String flashcardId,
  });
}

class FlashcardRemoteDataSourceImpl implements FlashcardRemoteDataSource {
  final FirebaseFirestore _firestore;

  FlashcardRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> createFlashcard({
    required String lessonId,
    required String flashcardSetId,
    required String front,
    required String back,
  }) async {
    try {
      await _firestore.collection('flashcards').add({
        'lessonId': lessonId,
        'flashcardSetId': flashcardSetId,
        'front': front,
        'back': back,
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Flashcard>> getFlashcardsBySetId({
    required String flashcardSetId,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('flashcards')
          .where('flashcardSetId', isEqualTo: flashcardSetId)
          .get();
      return snapshot.docs.map((doc) => FlashcardModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> createFlashcardSet({
    required String lessonId,
    required String title,
    required String description,
  }) async {
    try {
      await _firestore.collection('flashcardSets').add({
        'lessonId': lessonId,
        'title': title,
        'description': description,
        'createdAt': Timestamp.now(),
        'flashcardCount': 0,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateFlashcard({
    required String flashcardId,
    required String front,
    required String back,
  }) async {
    try {
      await _firestore.collection('flashcards').doc(flashcardId).update({
        'front': front,
        'back': back,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteFlashcard({required String flashcardId}) async {
    try {
      await _firestore.collection('flashcards').doc(flashcardId).delete();
    } catch (e) {
      throw Exception('Błąd podczas usuwania fiszki: $e');
    }
  }

  @override
  Future<void> updateLastReviewed({required String flashcardId}) async {
    try {
      await _firestore.collection('flashcards').doc(flashcardId).update({
        'lastReviewedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
