import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/lesson_model.dart';

abstract class LessonRemoteDataSource {
  Future<void> createLesson(LessonModel lesson);

  Future<List<LessonModel>> getLessons();
}

class LessonRemoteDataSourceImpl implements LessonRemoteDataSource {
  final FirebaseFirestore _firestore;

  LessonRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> createLesson(LessonModel lesson) async {
    try {
      await _firestore.collection('lessons').add(lesson.toMap());
    } catch (e) {
      // Tutaj możesz rzucić własny ServerException
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<LessonModel>> getLessons() async {
    try {
      final snapshot = await _firestore.collection('lessons').get();
      return snapshot.docs.map((doc) => LessonModel.fromSnapshot(doc)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
