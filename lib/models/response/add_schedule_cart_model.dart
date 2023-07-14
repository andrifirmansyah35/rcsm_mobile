import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/models/response/schedule_cart_model.dart';

part 'add_schedule_cart_model.g.dart';

@JsonSerializable(createToJson: false)
class AddScheduleCartModel extends Equatable {
  final String message;
  final String status;
  final ScheduleCartModel? data;

  const AddScheduleCartModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory AddScheduleCartModel.fromJson(Map<String, dynamic> json) =>
      _$AddScheduleCartModelFromJson(json);

  @override
  List<Object> get props => [message];
}
