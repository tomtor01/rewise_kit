import 'package:equatable/equatable.dart';
import '../../../../core/common/usecase/usecase.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../repositories/dashboard_repository.dart';

class UpdateFlashcardsProgressUseCase
    extends UseCaseWithParams<void, UpdateFlashcardProgressParams> {
  final DashboardRepository _repository;

  UpdateFlashcardsProgressUseCase(this._repository);

  @override
  FutureResult<void> call(UpdateFlashcardProgressParams params) =>
      _repository.markFlashcard(
        flashcardId: params.flashcardId,
        isLearned: params.isLearned,
      );
}

class UpdateFlashcardProgressParams extends Equatable {
  final String flashcardId;
  final bool isLearned;

  const UpdateFlashcardProgressParams({
    required this.flashcardId,
    required this.isLearned,
  });

  @override
  List<Object?> get props => [flashcardId, isLearned];
}