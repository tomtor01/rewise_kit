import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/lesson.dart';

class LessonModel extends Lesson {
  const LessonModel({
    required super.id,
    required super.title,
    required super.description,
    required super.creatorId,
    required super.createdAt,
  });

  factory LessonModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return LessonModel(
      id: doc.id,
      title: data['title'] as String,
      description: data['description'] as String,
      creatorId: data['creatorId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  static String normalizeText(String input) {
    return input
        .toLowerCase()
        .replaceAll('ą', 'a')
        .replaceAll('ć', 'c')
        .replaceAll('ę', 'e')
        .replaceAll('ł', 'l')
        .replaceAll('ń', 'n')
        .replaceAll('ó', 'o')
        .replaceAll('ś', 's')
        .replaceAll('ź', 'z')
        .replaceAll('ż', 'z');
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'creatorId': creatorId,
      'createdAt': Timestamp.fromDate(createdAt),
      'searchTitle': normalizeText(title),
    };
  }
}
