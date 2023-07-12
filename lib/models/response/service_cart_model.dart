import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_cart_model.g.dart';

@JsonSerializable(createToJson: false)
class ListServiceCartModel extends Equatable {
  final List<ServiceCartModel> dataKeranjangLayananOpen;
  final List<ServiceCartModel> dataKeranjangClose;

  const ListServiceCartModel({
    required this.dataKeranjangLayananOpen,
    required this.dataKeranjangClose,
  });

  factory ListServiceCartModel.fromJson(Map<String, dynamic> json) =>
      _$ListServiceCartModelFromJson(json);

  @override
  List<Object?> get props => [
        dataKeranjangLayananOpen,
        dataKeranjangClose,
      ];
}

@JsonSerializable(createToJson: false)
class ServiceCartModel extends Equatable {
  final int idKeranjangLayanan;
  final bool status;
  final String layanan;
  final String kategoriLayanan;
  final String harga;

  const ServiceCartModel({
    required this.idKeranjangLayanan,
    required this.status,
    required this.layanan,
    required this.kategoriLayanan,
    required this.harga,
  });

  factory ServiceCartModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCartModelFromJson(json);

  @override
  List<Object?> get props => [
        idKeranjangLayanan,
        status,
        layanan,
        kategoriLayanan,
      ];
}