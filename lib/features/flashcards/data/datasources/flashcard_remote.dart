import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/flashcard_model.dart';
import '../models/flashcard_set_model.dart';

abstract class FlashcardRemoteDataSource {
  Future<void> createFlashcard({
    required String flashcardSetId,
    required String front,
    required String back,
  });

  Future<void> createFlashcardSet({
    required String lessonId,
    required String title,
    required String description,
  });

  Future<List<FlashcardModel>> getFlashcardsBySetId({
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

  Future<List<FlashcardSetModel>> getFlashcardSets({
    required String lessonId,
  });
}

class FlashcardRemoteDataSourceImpl implements FlashcardRemoteDataSource {
  final FirebaseFirestore _firestore;

  FlashcardRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> createFlashcard({
    required String flashcardSetId,
    required String front,
    required String back,
  }) async {
    try {
      // Użyj batch do atomowej operacji
      final batch = _firestore.batch();

      // Dodaj fiszkę
      final flashcardRef = _firestore.collection('flashcards').doc();
      batch.set(flashcardRef, {
        'flashcardSetId': flashcardSetId,
        'front': front,
        'back': back,
        'createdAt': Timestamp.now(),
      });

      // Zwiększa licznik fiszek w zestawie
      final setRef = _firestore.collection('flashcardSets').doc(flashcardSetId);
      batch.update(setRef, {
        'flashcardCount': FieldValue.increment(1),
      });

      await batch.commit();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<FlashcardModel>> getFlashcardsBySetId({
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
      // Najpierw pobierz fiszkę żeby znać flashcardSetId
      final flashcardDoc = await _firestore.collection('flashcards').doc(flashcardId).get();
      if (!flashcardDoc.exists) {
        throw Exception('Fiszka nie istnieje');
      }

      final flashcardSetId = flashcardDoc.data()!['flashcardSetId'] as String;

      // Użyj batch do atomowej operacji
      final batch = _firestore.batch();

      // Usuń fiszkę
      batch.delete(_firestore.collection('flashcards').doc(flashcardId));

      // Zmniejsz licznik
      final setRef = _firestore.collection('flashcardSets').doc(flashcardSetId);
      batch.update(setRef, {
        'flashcardCount': FieldValue.increment(-1),
      });

      await batch.commit();
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

  @override
  Future<List<FlashcardSetModel>> getFlashcardSets({
    required String lessonId,
  }) async {
    final snapshot = await _firestore
        .collection('flashcardSets')
        .where('lessonId', isEqualTo: lessonId)
        .orderBy('createdAt', descending: false)
        .get();

    return snapshot.docs
        .map((doc) => FlashcardSetModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
