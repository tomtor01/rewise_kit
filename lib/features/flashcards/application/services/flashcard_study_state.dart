import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/flashcard.dart';

part 'flashcard_study_state.freezed.dart';

@freezed
abstract class FlashcardStudyState with _$FlashcardStudyState {
  const FlashcardStudyState._();
  const factory FlashcardStudyState({
    @Default([]) List<Flashcard> flashcards,
    @Default(0) int currentIndex,
    @Default(false) bool isRevealed,
    @Default(false) bool isLoading,
    @Default(false) bool isSessionComplete,
    @Default([]) List<bool> answeredCorrectly, // Nowe pole
    String? error,
  }) = _FlashcardStudyState;

  // Gettery dla statystyk
  int get correctAnswers => answeredCorrectly.where((answer) => answer).length;
  int get incorrectAnswers => answeredCorrectly.where((answer) => !answer).length;
  int get remainingFlashcards => flashcards.length - answeredCorrectly.length;
}