import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/models/response/service_cart_model.dart';

part 'add_service_cart_model.g.dart';

@JsonSerializable(createToJson: false)
class AddServiceCartModel extends Equatable {
  final String message;
  final String alert;
  final ServiceCartModel? data;

  const AddServiceCartModel({
    required this.message,
    required this.alert,
    this.data,
  });

  factory AddServiceCartModel.fromJson(Map<String, dynamic> json) =>
      _$AddServiceCartModelFromJson(json);

  @override
  List<Object> get props => [message];
}
