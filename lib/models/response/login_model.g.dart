// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      message: json['message'] as String,
      user: UserLoginModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

UserLoginModel _$UserLoginModelFromJson(Map<String, dynamic> json) =>
    UserLoginModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      photoProfile: json['photo_profile'] as String?,
    );
