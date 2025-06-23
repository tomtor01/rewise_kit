import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  final String id;
  final String title;
  final String description;
  final String creatorId;
  final DateTime createdAt;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.creatorId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, description, creatorId, createdAt];
}