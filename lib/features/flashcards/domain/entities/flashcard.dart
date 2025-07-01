import 'package:equatable/equatable.dart';

class Flashcard extends Equatable {
  final String frontText;
  final String backText;

  const Flashcard({
    required this.frontText,
    required this.backText,
  });

  @override
  List<Object?> get props => [frontText, backText];
}