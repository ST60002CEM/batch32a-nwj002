import 'package:json_annotation/json_annotation.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetCurrentUserDto {
  final String userId;
  final String fullname;
  final int phone; // Updated from String to int
  final String username;
  final String password;
  final int age; // Updated from String to int
  final String email;

  GetCurrentUserDto({
    required this.userId,
    required this.fullname,
    required this.phone,
    required this.username,
    required this.password,
    required this.age,
    required this.email,
  });

  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      fullname: fullname,
      phone: phone,
      username: username,
      password: password,
      age: age,
      email: email,
    );
  }

  Map<String, dynamic> toJson() => _$GetCurrentUserDtoToJson(this);

  factory GetCurrentUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentUserDtoFromJson(json);
}
