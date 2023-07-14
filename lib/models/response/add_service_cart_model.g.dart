// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_service_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddServiceCartModel _$AddServiceCartModelFromJson(Map<String, dynamic> json) =>
    AddServiceCartModel(
      message: json['message'] as String,
      alert: json['alert'] as String,
      data: json['data'] == null
          ? null
          : ServiceCartModel.fromJson(json['data'] as Map<String, dynamic>),
    );
