// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListReservationModel _$ListReservationModelFromJson(
        Map<String, dynamic> json) =>
    ListReservationModel(
      message: json['message'] as String,
      reservasiUserComplete: (json['reservasi_user_complete'] as List<dynamic>)
          .map((e) => ReservationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ReservationModel _$ReservationModelFromJson(Map<String, dynamic> json) =>
    ReservationModel(
      layananNama: json['layanan_nama'] as String,
      kategoriLayanan: json['kategori_layanan'] as String,
      tanggal: json['tanggal'] as String,
      operasi: json['operasi'] as String,
      harga: json['harga'] as String,
      status: $enumDecode(_$ReservationStatusTypeEnumMap, json['status']),
      gambar: json['gambar'] as String?,
    );

const _$ReservationStatusTypeEnumMap = {
  ReservationStatusType.antri: 'antri',
  ReservationStatusType.diproses: 'diproses',
  ReservationStatusType.selesai: 'selesai',
  ReservationStatusType.dibatalkan: 'dibatalkan',
  ReservationStatusType.tidakDatang: 'tidak datang',
};
