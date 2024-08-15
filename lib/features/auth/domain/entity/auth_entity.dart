import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fullname;
  final int age; // Updated from String to int
  final String username;
  final String password;
  final String email;
  final int phone; // Updated from String to int

  const AuthEntity({
    this.userId,
    required this.fullname,
    required this.age,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
  });

  const AuthEntity.empty()
      : userId = '',
        fullname = '',
        age = 0, // Default value set to 0
        username = '',
        password = '',
        email = '',
        phone = 0; // Default value set to 0

  @override
  List<Object?> get props => [
        userId,
        fullname,
        age,
        username,
        password,
        email,
        phone,
      ];
}
