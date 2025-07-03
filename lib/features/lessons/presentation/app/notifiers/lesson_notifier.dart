import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rewise_kit/core/services/injection_container.dart';
import 'package:rewise_kit/features/dashboard/presentation/app/notifiers/user_data_notifier.dart';
import 'package:rewise_kit/features/lessons/domain/usecases/create_lesson_usecase.dart';
import 'package:rewise_kit/features/lessons/domain/usecases/save_lesson_usecase.dart';
import 'package:rewise_kit/features/lessons/domain/usecases/unsave_lesson_usecase.dart';
import '../../../domain/usecases/delete_lesson_usecase.dart';
import '../providers/lesson_provider.dart';

part 'lesson_notifier.g.dart';

@riverpod
class LessonActions extends _$LessonActions {
  late final SaveLessonUseCase _saveLesson;
  late final UnsaveLessonUseCase _unsaveLesson;
  late final CreateLessonUseCase _createLesson;
  late final DeleteLessonUseCase _deleteLesson;

  @override
  void build() {
    _saveLesson = sl<SaveLessonUseCase>();
    _unsaveLesson = sl<UnsaveLessonUseCase>();
    _createLesson = sl<CreateLessonUseCase>();
    _deleteLesson = sl<DeleteLessonUseCase>();
  }

  Future<void> saveLesson(String lessonId) async {
    await _saveLesson(SaveLessonParams(lessonId: lessonId));
    ref.invalidate(userDataNotifierProvider);
  }

  Future<void> unsaveLesson(String lessonId) async {
    await _unsaveLesson(UnsaveLessonParams(lessonId: lessonId));
    ref.invalidate(userDataNotifierProvider);
  }

  Future<void> createLesson(String title, String description) async {
    await _createLesson(
      CreateLessonParams(title: title, description: description),
    );
    // Odświeża listę utworzonych lekcji
    ref.invalidate(createdLessonsProvider);
  }

  Future<void> deleteLesson(String lessonId) async {

    final result = await _deleteLesson(DeleteLessonParams(lessonId: lessonId));
    result.fold(
          (failure) {
        // Tutaj można obsłużyć błąd, np. poprzez wystawienie stanu błędu
        // lub pokazanie SnackBar'a z błędem w UI.
      },
          (_) {
        // Unieważnienie providerów, aby odświeżyć listę lekcji na stronie głównej
        ref.invalidate(createdLessonsProvider);
        ref.invalidate(savedLessonsProvider);
      },
    );
  }
}
