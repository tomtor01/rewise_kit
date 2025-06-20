import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? photoUrl;
  final bool emailVerified;

  const User({
    required this.id,
    this.email,
    this.name,
    this.photoUrl,
    required this.emailVerified,
  });

  static const empty = User(id: '', emailVerified: false);

  bool get isEmpty => this == User.empty;

  @override
  List<Object?> get props => [id, email, name, photoUrl, emailVerified];
}