import 'package:json_annotation/json_annotation.dart';

part 'change_password_body.g.dart';

@JsonSerializable(createFactory: false)
class ChangePasswordBody {
  final String passwordLama;
  final String passwordBaru;

  const ChangePasswordBody({
    required this.passwordLama,
    required this.passwordBaru,
  });

  Map<String, dynamic> toJson() => _$ChangePasswordBodyToJson(this);
}
