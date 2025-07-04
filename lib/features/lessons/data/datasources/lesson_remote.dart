import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/lesson_details_model.dart';
import '../models/lesson_model.dart';

abstract class LessonRemoteDataSource {
  Future<void> createLesson(LessonModel lesson);

  Future<List<LessonModel>> getCreatedLessons({required String creatorId});

  Future<LessonDetailsModel> getLessonById({required String lessonId});

  Future<List<LessonModel>> searchLessons({required String query});

  Future<void> saveLesson({required String userId, required String lessonId});

  Future<void> unsaveLesson({required String userId, required String lessonId});

  Future<List<LessonModel>> getSavedLessons({required List<String> lessonIds});

  Future<void> deleteLesson({required String lessonId});
}

class LessonRemoteDataSourceImpl implements LessonRemoteDataSource {
  final FirebaseFirestore _firestore;

  LessonRemoteDataSourceImpl(this._firestore);

  DocumentReference<Map<String, dynamic>> _userDoc(String userId) =>
      _firestore.collection('users').doc(userId);

  @override
  Future<void> createLesson(LessonModel lesson) async {
    try {
      await _firestore.collection('lessons').add(lesson.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<LessonModel>> getCreatedLessons({
    required String creatorId,
  }) async {
    try {
      final snapshot =
          await _firestore
              .collection('lessons')
              .where('creatorId', isEqualTo: creatorId)
              .get();

      return snapshot.docs.map((doc) => LessonModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<LessonDetailsModel> getLessonById({required String lessonId}) async {
    try {
      final doc = await _firestore.collection('lessons').doc(lessonId).get();
      if (!doc.exists) {
        throw Exception('Lesson not found');
      }

      //final contentSnapshot = await doc.reference.collection('content').get();

      return LessonDetailsModel.fromSnapshot(doc);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<LessonModel>> searchLessons({required String query}) async {
    try {
      if (query.isEmpty) {
        return [];
      }
      // '\uf8ff' to bardzo wysoki znak w Unicode, który pozwala
      // zamknąć zakres wyszukiwania.
      final normalizedQuery = LessonModel.normalizeText(query);

      final snapshot =
          await _firestore
              .collection('lessons')
              .where('searchTitle', isGreaterThanOrEqualTo: normalizedQuery)
              .where('searchTitle', isLessThanOrEqualTo: '$normalizedQuery\uf8ff')
              .limit(10)
              .get();

      return snapshot.docs.map((doc) => LessonModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<LessonModel>> getSavedLessons({
    required List<String> lessonIds,
  }) async {
    try {
      // Jeśli lista ID jest pusta, nie ma sensu wykonywać zapytania
      if (lessonIds.isEmpty) {
        return [];
      }
      final snapshot =
          await _firestore
              .collection('lessons')
              .where(FieldPath.documentId, whereIn: lessonIds)
              .get();

      return snapshot.docs.map((doc) => LessonModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> saveLesson({
    required String userId,
    required String lessonId,
  }) async {
    await _userDoc(userId).set({
      'savedLessonIds': FieldValue.arrayUnion([lessonId]),
    }, SetOptions(merge: true));
  }

  @override
  Future<void> unsaveLesson({
    required String userId,
    required String lessonId,
  }) async {
    await _userDoc(userId).update({
      'savedLessonIds': FieldValue.arrayRemove([lessonId]),
    });
  }

  @override
  Future<void> deleteLesson({required String lessonId}) async {
    try {
      await _firestore.collection('lessons').doc(lessonId).delete();
    } catch (e) {
      throw Exception('Błąd podczas usuwania lekcji: $e');
    }
  }
}
