// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_schedule_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddScheduleCartModel _$AddScheduleCartModelFromJson(
        Map<String, dynamic> json) =>
    AddScheduleCartModel(
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : ScheduleCartModel.fromJson(json['data'] as Map<String, dynamic>),
    );
