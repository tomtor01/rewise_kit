import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rewise_kit/core/services/injection_container.dart';
import '../../../../../core/common/providers/current_user_provider.dart';
import '../../../../dashboard/presentation/app/notifiers/user_data_notifier.dart';
import '../../../domain/entities/flashcard.dart';
import '../../../domain/entities/flashcard_set.dart';
import '../../../domain/usecases/create_flashcard_set_usecase.dart';
import '../../../domain/usecases/create_flashcard_usecase.dart';
import '../../../domain/usecases/delete_flashcard_usecase.dart';
import '../../../domain/usecases/get_flashcard_sets_usecase.dart';
import '../../../domain/usecases/get_flashcards_by_set_id_usecase.dart';
import '../../../domain/usecases/update_flashcard_usecase.dart';
import '../../../application/services/flashcard_study_state.dart';

part 'flashcard_notifier.g.dart';

// Provider dla akcji CRUD na zestawach fiszek
@riverpod
class FlashcardSetActions extends _$FlashcardSetActions {
  late final CreateFlashcardSetUseCase _createFlashcardSet;

  @override
  void build() {
    _createFlashcardSet = sl<CreateFlashcardSetUseCase>();
  }

  Future<void> createFlashcardSet(String title, String? description, String lessonId) async {
    final result = await _createFlashcardSet(
      CreateFlashcardSetParams(
        title: title,
        description: description,
        lessonId: lessonId,
      ),
    );

    result.fold(
          (failure) => throw Exception(failure.message),
          (_) {}, // Sukces
    );
  }
}

// Provider dla akcji CRUD na fiszkach
@riverpod
class FlashcardActions extends _$FlashcardActions {
  late final CreateFlashcardUseCase _createFlashcard;
  late final UpdateFlashcardUseCase _updateFlashcard;
  late final DeleteFlashcardUseCase _deleteFlashcard;

  @override
  void build() {
    _createFlashcard = sl<CreateFlashcardUseCase>();
    _updateFlashcard = sl<UpdateFlashcardUseCase>();
    _deleteFlashcard = sl<DeleteFlashcardUseCase>();
  }

  Future<void> createFlashcard(String question, String answer, String flashcardSetId) async {
    final result = await _createFlashcard(
      CreateFlashcardParams(
        front: question,
        back: answer,
        flashcardSetId: flashcardSetId,
      ),
    );

    result.fold(
          (failure) => throw Exception(failure.message),
          (_) {}, // Sukces
    );
  }

  Future<void> updateFlashcard(String id, String question, String answer) async {
    final result = await _updateFlashcard(
      UpdateFlashcardParams(
        flashcardId: id,
        front: question,
        back: answer,
      ),
    );

    result.fold(
          (failure) => throw Exception(failure.message),
          (_) {}, // Sukces
    );
  }

  Future<void> deleteFlashcard(String id) async {
    final result = await _deleteFlashcard(
      DeleteFlashcardParams(flashcardId: id),
    );

    result.fold(
          (failure) => throw Exception(failure.message),
          (_) {},
    );
  }
}

// Provider dla pobierania fiszek z zestawu
@riverpod
Future<List<Flashcard>> flashcardsBySet(Ref ref, String setId) async {
  final getFlashcards = sl<GetFlashcardsBySetIdUseCase>();
  final result = await getFlashcards(GetFlashcardsBySetIdParams(flashcardSetId: setId));

  return result.fold(
        (failure) => throw Exception(failure.message),
        (flashcards) => flashcards,
  );
}

@riverpod
Future<List<FlashcardSet>> flashcardSetsByLesson(Ref ref, String lessonId) async {
  final getFlashcardSets = sl<GetFlashcardSetsUseCase>();
  final result = await getFlashcardSets(GetFlashcardSetsParams(lessonId: lessonId));

  return result.fold(
        (failure) => throw Exception(failure.message),
        (flashcardSets) => flashcardSets,
  );
}

// Provider dla stanu nauki fiszek
@riverpod
class FlashcardStudy extends _$FlashcardStudy {
  late final GetFlashcardsBySetIdUseCase _getFlashcards;

  @override
  FlashcardStudyState build() {
    _getFlashcards = sl<GetFlashcardsBySetIdUseCase>();
    return const FlashcardStudyState();
  }

  Future<void> initializeStudySession(String flashcardSetId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _getFlashcards(
        GetFlashcardsBySetIdParams(flashcardSetId: flashcardSetId),
      );

      result.fold(
            (failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
        ),
            (flashcards) => state = state.copyWith(
          isLoading: false,
          flashcards: flashcards,
          currentIndex: 0,
          isRevealed: false,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void revealAnswer() {
    if (!state.isRevealed) {
      state = state.copyWith(isRevealed: true);
    }
  }

  void markFlashcard(bool isCorrect) {
    // Dodaje odpowiedź tylko jeśli jeszcze nie była zapisana dla tej fiszki
    final updatedAnswers = List<bool>.from(state.answeredCorrectly);

    // Jeśli to nowa odpowiedź, dodaje ją
    if (updatedAnswers.length <= state.currentIndex) {
      updatedAnswers.add(isCorrect);
    } else {
      // Jeśli już była odpowiedź, zaktualizuje ją
      updatedAnswers[state.currentIndex] = isCorrect;
    }

    state = state.copyWith(answeredCorrectly: updatedAnswers);

    // Zapisuje postęp fiszki do Firestore
    _saveFlashcardProgress(isCorrect);

    if (hasNext) {
      nextFlashcard();
    } else {
      state = state.copyWith(isSessionComplete: true);
    }
  }

  Future<void> _saveFlashcardProgress(bool isLearned) async {
    try {
      final currentUser = ref.read(currentUserProvider);
      final currentFlashcard = this.currentFlashcard;

      if (currentUser != null && currentFlashcard != null) {
        await ref.read(userDataNotifierProvider.notifier).markFlashcard(
          currentFlashcard.id,
          isLearned,
        );
      }
    } catch (e) {
      print('Błąd podczas zapisywania postępu: $e');
    }
  }

  void nextFlashcard() {
    if (hasNext) {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        isRevealed: false,
      );
    }
  }

  void previousFlashcard() {
    if (hasPrevious) {
      state = state.copyWith(
        currentIndex: state.currentIndex - 1,
        isRevealed: false,
      );
    }
  }

  void goToFlashcard(int index) {
    if (index >= 0 && index < state.flashcards.length) {
      state = state.copyWith(
        currentIndex: index,
        isRevealed: false,
      );
    }
  }

  void shuffleFlashcards() {
    final shuffled = List<Flashcard>.from(state.flashcards);
    shuffled.shuffle(Random());
    state = state.copyWith(
      flashcards: shuffled,
      currentIndex: 0,
      isRevealed: false,
    );
  }

  void startIncorrectOnly() {
    final incorrectFlashcards = <Flashcard>[];

    for (int i = 0; i < state.flashcards.length; i++) {
      if (i < state.answeredCorrectly.length && !state.answeredCorrectly[i]) {
        incorrectFlashcards.add(state.flashcards[i]);
      }
    }

    state = state.copyWith(
      flashcards: incorrectFlashcards,
      currentIndex: 0,
      isRevealed: false,
      isSessionComplete: false,
      answeredCorrectly: [],
    );
  }

  void resetSession() {
    state = state.copyWith(
      currentIndex: 0,
      isRevealed: false,
      isSessionComplete: false,
      answeredCorrectly: [],
    );
  }

  // Gettery pomocnicze
  bool get hasNext => state.currentIndex < state.flashcards.length - 1;
  bool get hasPrevious => state.currentIndex > 0;
  int get progress => state.flashcards.isEmpty
      ? 0
      : ((state.currentIndex + 1) / state.flashcards.length * 100).round();

  Flashcard? get currentFlashcard => state.flashcards.isEmpty
      ? null
      : state.flashcards[state.currentIndex];
}
