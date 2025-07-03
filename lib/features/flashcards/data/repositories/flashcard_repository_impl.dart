import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/common/error/failures.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../datasources/flashcard_remote.dart';
import '../models/flashcard_model.dart';

class FlashcardRepositoryImpl implements FlashcardRepository {
  final FlashcardRemoteDataSource remoteDataSource;
  final FirebaseAuth auth;

  FlashcardRepositoryImpl(this.remoteDataSource, this.auth);

  @override
  FutureResult<void> createFlashcard({
    required String lessonId,
    required String front,
    required String back,
  }) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return const Left(
          ServerFailure(message: 'User not logged in', statusCode: 401),
        );
      }

      final flashcardModel = FlashcardModel(
        id: '',
        lessonId: lessonId,
        front: front,
        back: back,
        createdAt: DateTime.now(),
      );

      final result = await remoteDataSource.createFlashcard(flashcardModel);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<List<Flashcard>> getFlashcardsByLessonId({
    required String lessonId,
  }) async {
    try {
      final result = await remoteDataSource.getFlashcardsByLessonId(
        lessonId: lessonId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<void> updateFlashcard({
    required String flashcardId,
    required String front,
    required String back,
  }) async {
    try {
      final flashcardModel = FlashcardModel(
        id: flashcardId,
        lessonId: '',
        front: front,
        back: back,
        createdAt: DateTime.now(),
      );

      final result = await remoteDataSource.updateFlashcard(flashcardModel);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<void> deleteFlashcard({required String flashcardId}) async {
    try {
      final result = await remoteDataSource.deleteFlashcard(
        flashcardId: flashcardId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<void> markAsLearned({required String flashcardId}) async {
    try {
      final result = await remoteDataSource.markAsLearned(
        flashcardId: flashcardId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<void> markAsNotLearned({required String flashcardId}) async {
    try {
      final result = await remoteDataSource.markAsNotLearned(
        flashcardId: flashcardId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }
}
