import 'package:equatable/equatable.dart';
import 'package:rewise_kit/features/lessons/domain/entities/lesson.dart';

class LessonState extends Equatable {
  final List<Lesson> searchResults;
  final bool isLoading;

  const LessonState({
    this.searchResults = const [],
    this.isLoading = false,
  });

  LessonState copyWith({
    List<Lesson>? searchResults,
    bool? isLoading,
  }) {
    return LessonState(
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [searchResults, isLoading];
}