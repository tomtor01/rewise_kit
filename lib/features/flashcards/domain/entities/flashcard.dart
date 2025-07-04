import 'package:equatable/equatable.dart';

class Flashcard extends Equatable {
  final String id;
  final String flashcardSetId;
  final String front;
  final String back;
  final DateTime createdAt;
  final DateTime? lastReviewedAt;

  const Flashcard({
    required this.id,
    required this.flashcardSetId,
    required this.front,
    required this.back,
    required this.createdAt,
    this.lastReviewedAt,
  });

  @override
  List<Object?> get props => [
    id,
    flashcardSetId,
    front,
    back,
    createdAt,
    lastReviewedAt,
  ];
}