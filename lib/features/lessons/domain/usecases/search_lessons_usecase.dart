import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../entities/lesson.dart';
import '../repositories/lesson_repository.dart';

class SearchLessonsUseCase
    extends UseCaseWithParams<List<Lesson>, SearchLessonsParams> {
  final LessonRepository _repository;

  SearchLessonsUseCase(this._repository);

  @override
  FutureResult<List<Lesson>> call(SearchLessonsParams params) async =>
      _repository.searchLessons(query: params.query);
}

class SearchLessonsParams {
  final String query;

  SearchLessonsParams({required this.query});
}