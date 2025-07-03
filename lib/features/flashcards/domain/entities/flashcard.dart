import 'package:equatable/equatable.dart';

class Flashcard extends Equatable {
  final String id;
  final String lessonId;
  final String front;
  final String back;
  final DateTime createdAt;
  final DateTime? lastReviewedAt;

  const Flashcard({
    required this.id,
    required this.lessonId,
    required this.front,
    required this.back,
    required this.createdAt,
    this.lastReviewedAt,
  });

  @override
  List<Object?> get props => [
    id,
    lessonId,
    front,
    back,
    createdAt,
    lastReviewedAt,
  ];
}