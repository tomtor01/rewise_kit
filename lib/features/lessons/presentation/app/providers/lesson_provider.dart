import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rewise_kit/core/common/providers/current_user_provider.dart';
import 'package:rewise_kit/core/services/injection_container.dart';
import 'package:rewise_kit/features/dashboard/presentation/app/notifiers/user_data_notifier.dart';
import 'package:rewise_kit/features/lessons/domain/entities/lesson.dart';
import 'package:rewise_kit/features/lessons/domain/entities/lesson_details.dart';
import 'package:rewise_kit/features/lessons/domain/usecases/get_created_lessons_usecase.dart';
import 'package:rewise_kit/features/lessons/domain/usecases/get_lesson_by_id_usecase.dart';
import 'package:rewise_kit/features/lessons/domain/usecases/get_saved_lessons_usecase.dart';
import 'package:rewise_kit/features/lessons/domain/usecases/search_lessons_usecase.dart';

part 'lesson_provider.g.dart';

// Enum do filtrowania
enum LessonFilter { all, created, saved }

// Provider przechowujący aktualny filtr
@riverpod
class CurrentLessonFilter extends _$CurrentLessonFilter {
  @override
  LessonFilter build() => LessonFilter.all;

  void setFilter(LessonFilter filter) => state = filter;
}

// Provider przechowujący aktualne zapytanie wyszukiwania
@riverpod
class LessonSearchQuery extends _$LessonSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) => state = query;
}

@riverpod
Future<List<Lesson>> savedLessons(Ref ref) async {
  final userDataAsyncValue = ref.watch(userDataNotifierProvider);
  final getSavedLessons = sl<GetSavedLessonsUseCase>();

  return userDataAsyncValue.when(
    data: (userData) async {
      if (userData == null || userData.savedLessonIds.isEmpty) {
        return [];
      }
      final result = await getSavedLessons(
        GetSavedLessonsParams(lessonIds: userData.savedLessonIds.toList()),
      );
      return result.fold((l) => throw l.message, (r) => r);
    },
    // Kiedy userDataNotifier jest w stanie ładowania, ten provider
    // również będzie w stanie ładowania. Zwracamy Future, który nigdy
    // się nie kończy, aby "wstrzymać" provider do czasu, aż dane
    // użytkownika będą dostępne.
    loading: () => Completer<List<Lesson>>().future,
    error: (err, stack) => throw err,
  );
}

// Provider dostarczający listę UTWORZONYCH lekcji
@riverpod
Future<List<Lesson>> createdLessons(Ref ref) async {
  final currentUser = ref.watch(currentUserProvider);
  if (currentUser == null) return [];

  final getCreatedLessons = sl<GetCreatedLessonsUseCase>();
  final result = await getCreatedLessons(
    GetCreatedLessonsParams(creatorId: currentUser.uid),
  );
  return result.fold((l) => throw l.message, (r) => r);
}

// Provider dostarczający WYSZUKANE lekcje
@riverpod
Future<List<Lesson>> searchedLessons(Ref ref) async {
  final query = ref.watch(lessonSearchQueryProvider);
  if (query.isEmpty) {
    return [];
  }
  const debounceDuration = Duration(milliseconds: 2000);

  // Anuluj poprzednie zapytanie, jeśli użytkownik nadal pisze
  final link = ref.keepAlive();
  Timer? timer;

  ref.onDispose(() {
    timer?.cancel();
  });

  final completer = Completer<List<Lesson>>();

  // Ustawia nowy timer. Wyszukiwanie uruchomi się po upływie debounceDuration.
  timer = Timer(debounceDuration, () async {
    final searchLessons = sl<SearchLessonsUseCase>();
    final result = await searchLessons(SearchLessonsParams(query: query));

    result.fold(
          (l) => completer.completeError(l),
          (r) => completer.complete(r),
    );
    // Gdy timer zakończy pracę, można pozwolić na usunięcie providera
    link.close();
  });

  // Zwraca Future, które zostanie uzupełnione, gdy timer zakończy pracę
  return completer.future;
}

// główny provider, który łączy, filtruje i dostarcza dane do UI
@riverpod
Future<List<Lesson>> filteredLessons(Ref ref) async {
  final filter = ref.watch(currentLessonFilterProvider);
  final query = ref.watch(lessonSearchQueryProvider);

  // Jeśli jest zapytanie, priorytetem jest wyszukiwanie
  if (query.isNotEmpty) {
    return ref.watch(searchedLessonsProvider.future);
  }

  // W przeciwnym razie, filtruj na podstawie wybranej opcji
  switch (filter) {
    case LessonFilter.created:
      return ref.watch(createdLessonsProvider.future);
    case LessonFilter.saved:
      return ref.watch(savedLessonsProvider.future);
    case LessonFilter.all:
    // Łączy utworzone i zapisane, usuwając duplikaty
      final created = await ref.watch(createdLessonsProvider.future);
      final saved = await ref.watch(savedLessonsProvider.future);
      final allLessons = {...created, ...saved}.toList();
      return allLessons;
  }
}

// Provider dostarczający szczegóły konkretnej lekcji
@riverpod
Future<LessonDetails> lessonDetails(Ref ref, String lessonId) async {
  final getLessonById = sl<GetLessonByIdUseCase>();
  final result = await getLessonById(GetLessonByIdParams(lessonId: lessonId));
  return result.fold((l) => throw l.message, (r) => r);
}
