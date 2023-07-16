import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/common/enum.dart';

part 'list_reservation_model.g.dart';

@JsonSerializable(createToJson: false)
class ListReservationModel extends Equatable {
  final String message;
  final List<ReservationModel> reservasiUserComplete;

  const ListReservationModel({
    required this.message,
    required this.reservasiUserComplete,
  });

  factory ListReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ListReservationModelFromJson(json);

  @override
  List<Object> get props => [
        message,
        reservasiUserComplete,
      ];
}

@JsonSerializable(createToJson: false)
class ReservationModel extends Equatable {
  final String layananNama;
  final String kategoriLayanan;
  final String tanggal;
  final String operasi;
  final String harga;
  final ReservationStatusType status;
  final String? gambar;

  const ReservationModel({
    required this.layananNama,
    required this.kategoriLayanan,
    required this.tanggal,
    required this.operasi,
    required this.harga,
    required this.status,
    required this.gambar,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);

  @override
  List<Object?> get props => [
        layananNama,
        kategoriLayanan,
        tanggal,
        operasi,
        harga,
        status,
        gambar,
      ];
}
