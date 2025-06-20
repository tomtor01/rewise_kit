import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String? email;
  final String? name;
  final bool emailVerified;

  const User({
    required this.uid,
    this.email,
    this.name,
    required this.emailVerified,
  });

  static const empty = User(uid: '', emailVerified: false);

  bool get isEmpty => this == User.empty;

  @override
  List<Object?> get props => [uid, email, name, emailVerified];
}