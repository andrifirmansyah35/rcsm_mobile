// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListScheduleCartModel _$ListScheduleCartModelFromJson(
        Map<String, dynamic> json) =>
    ListScheduleCartModel(
      keranjangOperasiBuka: (json['keranjang_operasi_buka'] as List<dynamic>)
          .map((e) => ScheduleCartModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      keranjangOperasiTerblokir:
          (json['keranjang_operasi_terblokir'] as List<dynamic>)
              .map((e) => ScheduleCartModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

ScheduleCartModel _$ScheduleCartModelFromJson(Map<String, dynamic> json) =>
    ScheduleCartModel(
      id: json['id'] as int,
      idOperasi: json['id_operasi'] as int,
      status: json['status'] as bool,
      userId: json['user_id'] as int,
      userNama: json['user_nama'] as String,
      operasi: json['operasi'] as String,
      jadwalOperasi: json['jadwal_operasi'] as String,
    );
