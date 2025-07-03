import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/flashcard_model.dart';

abstract class FlashcardRemoteDataSource {
  Future<void> createFlashcard(FlashcardModel flashcard);

  Future<List<FlashcardModel>> getFlashcardsByLessonId({
    required String lessonId,
  });

  Future<void> updateFlashcard(FlashcardModel flashcard);

  Future<void> deleteFlashcard({required String flashcardId});

  Future<void> markAsLearned({required String flashcardId});

  Future<void> markAsNotLearned({required String flashcardId});
}

class FlashcardRemoteDataSourceImpl implements FlashcardRemoteDataSource {
  final FirebaseFirestore _firestore;

  FlashcardRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> createFlashcard(FlashcardModel flashcard) async {
    try {
      await _firestore.collection('flashcards').add(flashcard.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<FlashcardModel>> getFlashcardsByLessonId({
    required String lessonId,
  }) async {
    try {
      final snapshot =
          await _firestore
              .collection('flashcards')
              .where('lessonId', isEqualTo: lessonId)
              .orderBy('createdAt', descending: false)
              .get();

      return snapshot.docs
          .map((doc) => FlashcardModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateFlashcard(FlashcardModel flashcard) async {
    try {
      await _firestore.collection('flashcards').doc(flashcard.id).update({
        'front': flashcard.front,
        'back': flashcard.back,
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
  Future<void> markAsLearned({required String flashcardId}) async {
    try {
      await _firestore.collection('flashcards').doc(flashcardId).update({
        'isLearned': true,
        'lastReviewedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> markAsNotLearned({required String flashcardId}) async {
    try {
      await _firestore.collection('flashcards').doc(flashcardId).update({
        'isLearned': false,
        'lastReviewedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
