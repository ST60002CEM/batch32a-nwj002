// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCurrentUserDto _$GetCurrentUserDtoFromJson(Map<String, dynamic> json) =>
    GetCurrentUserDto(
      userId: json['userId'] as String,
      fullname: json['fullname'] as String,
      phone: (json['phone'] as num).toInt(),
      username: json['username'] as String,
      password: json['password'] as String,
      age: (json['age'] as num).toInt(),
      email: json['email'] as String,
    );

Map<String, dynamic> _$GetCurrentUserDtoToJson(GetCurrentUserDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'fullname': instance.fullname,
      'phone': instance.phone,
      'username': instance.username,
      'password': instance.password,
      'age': instance.age,
      'email': instance.email,
    };
