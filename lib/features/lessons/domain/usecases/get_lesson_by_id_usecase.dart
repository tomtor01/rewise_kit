import 'package:equatable/equatable.dart';
import 'package:rewise_kit/core/common/usecase/usecase.dart';
import 'package:rewise_kit/core/common/utils/typedefs.dart';

import '../entities/lesson_details.dart';
import '../repositories/lesson_repository.dart';

class GetLessonByIdUseCase
    extends UseCaseWithParams<LessonDetails, GetLessonByIdParams> {
  final LessonRepository _repository;

  const GetLessonByIdUseCase(this._repository);

  @override
  FutureResult<LessonDetails> call(GetLessonByIdParams params) =>
      _repository.getLessonById(lessonId: params.lessonId);
}

class GetLessonByIdParams extends Equatable {
  final String lessonId; // Zmieniony parametr

  const GetLessonByIdParams({required this.lessonId});

  @override
  List<Object?> get props => [lessonId];
}
