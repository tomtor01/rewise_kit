import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rewise_kit/core/common/providers/current_user_provider.dart';
import 'package:rewise_kit/core/services/injection_container.dart';

import '../../../../flashcards/presentation/app/controllers/flashcard_notifier.dart';
import '../../../domain/entities/user_data.dart';
import '../../../domain/usecases/get_user_data_usecase.dart';
import '../../../domain/usecases/update_flashcards_progress_usecase.dart';
import '../state/user_progress_state.dart';

part 'user_data_notifier.g.dart';

@riverpod
class UserDataNotifier extends _$UserDataNotifier {
  final GetUserDataUseCase _getUserData = sl<GetUserDataUseCase>();
  final UpdateFlashcardsProgressUseCase _updateProgress =
      sl<UpdateFlashcardsProgressUseCase>();

  @override
  Future<UserData?> build() {
    final currentUser = ref.watch(currentUserProvider);

    if (currentUser == null) {
      return Future.value(null);
    }
    return _fetchUserData(currentUser.uid);
  }

  Future<UserData?> _fetchUserData(String uid) async {
    final result = await _getUserData(GetUserDataParams(userId: uid));
    return result.fold((failure) => throw failure, (userData) => userData);
  }

  Future<void> markFlashcard(String flashcardId, bool isLearned) async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) return;

    try {
      final result = await _updateProgress(
        UpdateFlashcardProgressParams(
          flashcardId: flashcardId,
          isLearned: isLearned,
        ),
      );

      result.fold((failure) => throw Exception(failure.message), (_) {
        // Odświeża dane po udanej aktualizacji
        ref.invalidate(userDataNotifierProvider);
      });
    } catch (e) {
      throw Exception('Błąd podczas zapisywania postępu: $e');
    }
  }
}

// Provider do obliczania statystyk użytkownika
@riverpod
Future<UserProgressStats> userProgressStats(UserProgressStatsRef ref) async {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) {
    return const UserProgressStats(
      totalFlashcards: 0,
      learnedFlashcards: 0,
      remainingFlashcards: 0,
      totalFlashcardSets: 0,
    );
  }

  final userData = await ref.watch(userDataNotifierProvider.future);
  if (userData == null) {
    return const UserProgressStats(
      totalFlashcards: 0,
      learnedFlashcards: 0,
      remainingFlashcards: 0,
      totalFlashcardSets: 0,
    );
  }

  int totalFlashcards = 0;
  int totalFlashcardSets = 0;
  final Set<String> allFlashcardIds = {};

  // Pobierz wszystkie fiszki z zapisanych lekcji
  for (final lessonId in userData.savedLessonIds) {
    try {
      // Pobiera zestawy fiszek dla danej lekcji
      final flashcardSets = await ref.read(
        flashcardSetsByLessonProvider(lessonId).future,
      );
      totalFlashcardSets += flashcardSets.length;

      for (final set in flashcardSets) {
        final flashcards = await ref.read(
          flashcardsBySetProvider(set.id).future,
        );
        totalFlashcards += flashcards.length;

        // Dodaje ID fiszek do zbioru (dla sprawdzenia postępu)
        for (final flashcard in flashcards) {
          allFlashcardIds.add(flashcard.id);
        }
      }
    } catch (e) {
      print('Błąd podczas pobierania fiszek dla lekcji $lessonId: $e');
    }
  }

  // Policz zapamiętane fiszki - tylko te które rzeczywiście istnieją
  int learnedFlashcards = 0;
  for (final flashcardId in allFlashcardIds) {
    if (userData.flashcardProgress[flashcardId] == true) {
      learnedFlashcards++;
    }
  }

  return UserProgressStats(
    totalFlashcards: totalFlashcards,
    learnedFlashcards: learnedFlashcards,
    remainingFlashcards: totalFlashcards - learnedFlashcards,
    totalFlashcardSets: totalFlashcardSets,
  );
}
