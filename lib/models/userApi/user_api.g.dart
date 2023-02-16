// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApi _$UserApiFromJson(Map<String, dynamic> json) => UserApi(
      full_name: json['full_name'] as String,
      email: json['email'] as String,
      role: json['role'] as int,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserApiToJson(UserApi instance) => <String, dynamic>{
      'full_name': instance.full_name,
      'email': instance.email,
      'role': instance.role,
      'password': instance.password,
    };
