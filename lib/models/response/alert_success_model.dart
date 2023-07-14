import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alert_success_model.g.dart';

@JsonSerializable(createToJson: false)
class AlertSuccessModel extends Equatable {
  final String message;
  final String alert;

  const AlertSuccessModel({
    required this.message,
    required this.alert,
  });

  factory AlertSuccessModel.fromJson(Map<String, dynamic> json) =>
      _$AlertSuccessModelFromJson(json);

  @override
  List<Object> get props => [message];
}
