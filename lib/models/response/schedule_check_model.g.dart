// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_check_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleCheckModel _$ScheduleCheckModelFromJson(Map<String, dynamic> json) =>
    ScheduleCheckModel(
      message: json['message'] as String,
      operasional: (json['operasional'] as List<dynamic>?)
              ?.map((e) => OperasionalModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

OperasionalModel _$OperasionalModelFromJson(Map<String, dynamic> json) =>
    OperasionalModel(
      id: json['id'] as int,
      jadwalOperasiId: json['jadwal_operasi_id'] as int,
      status: json['status'] as bool,
      waktuMulai: json['waktu_mulai'] as String,
      waktuSelesai: json['waktu_selesai'] as String,
    );
