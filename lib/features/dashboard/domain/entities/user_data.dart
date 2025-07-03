import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final Set<String> savedLessonIds;
  final Map<String, bool> flashcardProgress; // flashcardId -> isLearned

  const UserData({
    required this.savedLessonIds,
    required this.flashcardProgress,
  });

  const UserData.empty()
      : savedLessonIds = const {},
        flashcardProgress = const {};

  @override
  List<Object?> get props => [savedLessonIds, flashcardProgress];
}