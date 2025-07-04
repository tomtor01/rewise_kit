import '../../domain/entities/user_data.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    required super.savedLessonIds,
    required super.flashcardProgress,
  });

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      savedLessonIds: Set<String>.from(map['savedLessonIds'] as List<dynamic>? ?? []),
      flashcardProgress: Map<String, bool>.from(map['flashcardProgress'] as Map<String, dynamic>? ?? {}),
    );
  }

  const UserDataModel.empty() : super.empty();

  Map<String, dynamic> toMap() {
    return {
      'savedLessonIds': savedLessonIds.toList(),
      'flashcardProgress': flashcardProgress,
    };
  }

  UserDataModel copyWith({
    Set<String>? savedLessonIds,
    Map<String, bool>? flashcardProgress,
  }) {
    return UserDataModel(
      savedLessonIds: savedLessonIds ?? this.savedLessonIds,
      flashcardProgress: flashcardProgress ?? this.flashcardProgress,
    );
  }
}