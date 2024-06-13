import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fullname;
  final String age;
  final String username;
  final String password;
  final String email;

  const AuthEntity({
    this.id,
    required this.fullname,
    required this.age,
    required this.username,
    required this.password,
    required this.email,
  });

  @override
  List<Object?> get props => [id, fullname, age, username, password, email];
}
