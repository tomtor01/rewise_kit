import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/lesson_details.dart';

class LessonDetailsModel extends LessonDetails {
  const LessonDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.creatorId,
    required super.createdAt,
    required super.content,
  });

  // Ta metoda pobiera dane z dokumentu głównego
  // W przyszłości będzie też pobierać dane z subkolekcji 'content'
  factory LessonDetailsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return LessonDetailsModel(
      id: doc.id,
      title: data['title'] as String,
      description: data['description'] as String,
      creatorId: data['creatorId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      content: [],
    );
  }
}