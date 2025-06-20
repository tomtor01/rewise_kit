import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/common/entities/user.dart' as my_user;
import '../../../../core/common/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<my_user.User> registerUser({
    required String email,
    required String password,
  });

  Future<my_user.User> loginUser({
    required String email,
    required String password,
  });

  Future<void> logoutUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  const AuthRemoteDataSourceImpl(this._firebaseAuth);

  @override
  Future<my_user.User> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user == null) {
        throw const ServerException(message: 'User not found', statusCode: 404);
      }
      return UserModel.fromFirebaseUser(result.user!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? 'Unknown error', statusCode: 500);
    }
  }

  @override
  Future<my_user.User> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user == null) {
        throw const ServerException(message: 'User not created', statusCode: 500);
      }
      return UserModel.fromFirebaseUser(result.user!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? 'Unknown error', statusCode: 500);
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message ?? 'Unknown error', statusCode: 500);
    }
  }
}