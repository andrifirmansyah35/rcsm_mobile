import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'default_model.g.dart';

@JsonSerializable(createToJson: false)
class DefaultModel extends Equatable {
  final String message;

  const DefaultModel({
    required this.message,
  });

  factory DefaultModel.fromJson(Map<String, dynamic> json) =>
      _$DefaultModelFromJson(json);

  @override
  List<Object> get props => [message];
}
