import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/common/error/failures.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/entities/flashcard_set.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../datasources/flashcard_remote.dart';

class FlashcardRepositoryImpl implements FlashcardRepository {
  final FlashcardRemoteDataSource remoteDataSource;
  final FirebaseAuth auth;

  FlashcardRepositoryImpl(this.remoteDataSource, this.auth);

  @override
  FutureResult<void> createFlashcard({
    required String flashcardSetId,
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

      final result = await remoteDataSource.createFlashcard(
        flashcardSetId: flashcardSetId,
        front: front,
        back: back,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<void> createFlashcardSet({
    required String lessonId,
    required String title,
    String? description,
  }) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return const Left(
          ServerFailure(message: 'User not logged in', statusCode: 401),
        );
      }
      description ??= '';

      final result = await remoteDataSource.createFlashcardSet(
        lessonId: lessonId,
        title: title,
        description: description,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<List<Flashcard>> getFlashcardsBySetId({
    required String flashcardSetId,
  }) async {
    try {
      final result = await remoteDataSource.getFlashcardsBySetId(
        flashcardSetId: flashcardSetId,
      );
      final flashcards = result.map((model) => model as Flashcard).toList();
      return Right(flashcards);
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
      final result = await remoteDataSource.updateFlashcard(
        flashcardId: flashcardId,
        front: front,
        back: back,
      );
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
  FutureResult<void> updateLastReviewed({required String flashcardId}) async {
    try {
      await remoteDataSource.updateLastReviewed(flashcardId: flashcardId);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<List<FlashcardSet>> getFlashcardSets({
    required String lessonId,
  }) async {
    try {
      final result = await remoteDataSource.getFlashcardSets(
        lessonId: lessonId,
      );
      final flashcardSets = result.map((model) => model as FlashcardSet).toList();
      return Right(flashcardSets);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }
}
