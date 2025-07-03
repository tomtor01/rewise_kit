import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/common/error/failures.dart';
import '../../../../core/common/utils/typedefs.dart';
import '../../domain/entities/lesson.dart';
import '../../domain/entities/lesson_details.dart';
import '../../domain/repositories/lesson_repository.dart';
import '../datasources/lesson_remote.dart';
import '../models/lesson_model.dart';

class LessonRepositoryImpl implements LessonRepository {
  final LessonRemoteDataSource remoteDataSource;
  final FirebaseAuth auth; // Potrzebne do pobrania ID twórcy

  LessonRepositoryImpl(this.remoteDataSource, this.auth);

  @override
  FutureResult<void> createLesson({
    required String title,
    required String description,
  }) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return const Left(
          ServerFailure(message: 'User not logged in', statusCode: 401),
        );
      }
      final lessonModel = LessonModel(
        id: '',
        // Firestore wygeneruje ID
        title: title,
        description: description,
        creatorId: user.uid,
        createdAt: DateTime.now(),
      );
      final result = await remoteDataSource.createLesson(lessonModel);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<List<Lesson>> getCreatedLessons({required String creatorId}) async {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        return const Left(
          ServerFailure(message: 'User not logged in', statusCode: 401),
        );
      }
      final result = await remoteDataSource.getCreatedLessons(
        creatorId: userId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<LessonDetails> getLessonById({required String lessonId}) async {
    try {
      final result = await remoteDataSource.getLessonById(lessonId: lessonId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<List<Lesson>> searchLessons({required String query}) async {
    try {
      final lessonModels = await remoteDataSource.searchLessons(query: query);
      return Right(lessonModels);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<void> saveLesson({required String lessonId}) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return Left(
          ServerFailure(message: 'Użytkownik niezalogowany', statusCode: 401),
        );
      }
      await remoteDataSource.saveLesson(userId: user.uid, lessonId: lessonId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<void> unsaveLesson({required String lessonId}) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        return Left(
          ServerFailure(message: 'Użytkownik niezalogowany', statusCode: 401),
        );
      }
      await remoteDataSource.unsaveLesson(userId: user.uid, lessonId: lessonId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<List<Lesson>> getSavedLessons(
      {required List<String> lessonIds}) async {
    try {
      if (lessonIds.isEmpty) {
        return const Right([]);
      }
      final result = await remoteDataSource.getSavedLessons(lessonIds: lessonIds);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  FutureResult<void> deleteLesson({required String lessonId}) async {
    try {
      final result = await remoteDataSource.deleteLesson(lessonId: lessonId);
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }
}
