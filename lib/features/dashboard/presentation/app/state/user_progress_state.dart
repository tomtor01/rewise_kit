import 'package:equatable/equatable.dart';

class UserProgressStats extends Equatable {
  final int totalFlashcards;
  final int learnedFlashcards;
  final int remainingFlashcards;
  final int totalFlashcardSets;

  const UserProgressStats({
    required this.totalFlashcards,
    required this.learnedFlashcards,
    required this.remainingFlashcards,
    required this.totalFlashcardSets,
  });

  double get progressPercentage {
    if (totalFlashcards == 0) return 0.0;
    return (learnedFlashcards / totalFlashcards) * 100;
  }

  @override
  List<Object?> get props => [
    totalFlashcards,
    learnedFlashcards,
    remainingFlashcards,
    totalFlashcardSets,
  ];
}