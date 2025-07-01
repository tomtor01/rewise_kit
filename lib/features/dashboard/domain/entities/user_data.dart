import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final Set<String> savedLessonIds;

  const UserData({
    required this.savedLessonIds,
  });

  // Pusta encja na wypadek, gdyby użytkownik nie miał jeszcze żadnych danych
  const UserData.empty() : this(savedLessonIds: const {});

  @override
  List<Object?> get props => [savedLessonIds];
}