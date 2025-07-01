import '../../domain/entities/user_data.dart';

class UserDataModel extends UserData {
  const UserDataModel({required super.savedLessonIds});

  // Konwertuje mapę (np. z Firestore) na model
  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      savedLessonIds: Set<String>.from(map['savedLessonIds'] as List<dynamic>),
    );
  }

  // Pusty model
  const UserDataModel.empty() : super(savedLessonIds: const {});

  // Konwertuje model na mapę (do zapisu w Firestore)
  Map<String, dynamic> toMap() {
    return {
      'savedLessonIds': savedLessonIds.toList(),
    };
  }

  // Metoda copyWith do łatwej modyfikacji obiektu
  UserDataModel copyWith({
    Set<String>? savedLessonIds,
  }) {
    return UserDataModel(
      savedLessonIds: savedLessonIds ?? this.savedLessonIds,
    );
  }
}