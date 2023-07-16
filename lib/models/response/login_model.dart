import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(createToJson: false)
class LoginModel extends Equatable {
  final String message;
  final UserLoginModel user;
  final String token;

  const LoginModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  @override
  List<Object> get props => [message, user, token];
}

@JsonSerializable(createToJson: false)
class UserLoginModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? photoProfile;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) =>
      _$UserLoginModelFromJson(json);

  const UserLoginModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoProfile,
  });

  @override
  List<Object?> get props => [id, name, photoProfile];
}
