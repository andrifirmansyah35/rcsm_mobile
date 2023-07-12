import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_service_model.g.dart';

@JsonSerializable(createToJson: false)
class ListServiceModel extends Equatable {
  final String message;
  final String kategoriLayanan;
  final List<ServiceModel> layananAll;

  const ListServiceModel({
    required this.message,
    required this.kategoriLayanan,
    required this.layananAll,
  });

  factory ListServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ListServiceModelFromJson(json);

  @override
  List<Object?> get props => [
    message,
    kategoriLayanan,
    layananAll,
  ];
}

@JsonSerializable(createToJson: false)
class ServiceModel extends Equatable {
  final int id;
  // final String kategoriLayananId;
  final String nama;
  final String slug;
  final String harga;
  final String? deskripsi;
  final bool status;

  const ServiceModel({
    required this.id,
    // required this.kategoriLayananId,
    required this.nama,
    required this.slug,
    required this.harga,
    this.deskripsi,
    required this.status,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        // kategoriLayananId,
        nama,
        slug,
        harga,
        deskripsi,
        status,
      ];
}
