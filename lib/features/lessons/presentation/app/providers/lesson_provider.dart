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

part 'lesson_provider.g.dart';

// Provider dostarczający listę zapisanych lekcji
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
    loading: () => Completer<List<Lesson>>().future,
    error: (err, stack) => throw err,
  );
}

// Provider dostarczający listę utworzonych lekcji
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

// Provider dostarczający szczegóły konkretnej lekcji
@riverpod
Future<LessonDetails> lessonDetails(Ref ref, String lessonId) async {
  final getLessonById = sl<GetLessonByIdUseCase>();
  final result = await getLessonById(GetLessonByIdParams(lessonId: lessonId));
  return result.fold((l) => throw l.message, (r) => r);
}
