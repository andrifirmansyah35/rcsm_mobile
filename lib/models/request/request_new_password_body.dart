import 'package:json_annotation/json_annotation.dart';

part 'request_new_password_body.g.dart';

@JsonSerializable(createFactory: false)
class RequestNewPasswordBody {
  final String email;
  final String token;
  final String passwordBaru;

  const RequestNewPasswordBody({
    required this.email,
    required this.token,
    required this.passwordBaru,
  });

  Map<String, dynamic> toJson() => _$RequestNewPasswordBodyToJson(this);
}
