import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../../../core/common/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    super.email,
    super.name,
    super.photoUrl,
    required super.emailVerified,
  });

  /// Tworzy instancję `UserModel` na podstawie obiektu `User` z Firebase Auth.
  factory UserModel.fromFirebaseAuth(firebase.User authUser) {
    return UserModel(
      id: authUser.uid,
      email: authUser.email,
      name: authUser.displayName,
      photoUrl: authUser.photoURL,
      emailVerified: authUser.emailVerified,
    );
  }

  /// Tworzy instancję `UserModel` na podstawie dokumentu z Firestore.
  /// Używane do wczytywania dodatkowych, niestandardowych danych profilowych.
  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return UserModel(
      id: doc.id,
      email: data['email'] as String,
      name: data['name'] as String?,
      photoUrl: data['photoUrl'] as String?,
      emailVerified: data['emailVerified'] as bool? ?? false,
    );
  }

  /// Kopiuje obiekt, pozwalając na modyfikację wybranych pól.
  /// Niezbędne do niemutowalnego zarządzania stanem.
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
    bool? emailVerified,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'emailVerified': emailVerified,
    };
  }
}