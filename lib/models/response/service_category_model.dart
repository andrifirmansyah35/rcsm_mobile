import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_category_model.g.dart';

@JsonSerializable(createToJson: false)
class ServiceCategoryResponseModel extends Equatable {
  final String message;
  final List<ServiceCategoryModel> kategoriLayanan;

  factory ServiceCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryResponseModelFromJson(json);

  const ServiceCategoryResponseModel(this.message, this.kategoriLayanan);

  @override
  List<Object?> get props => [message, kategoriLayanan];
}

@JsonSerializable(createToJson: false)
class ServiceCategoryModel extends Equatable {
  final int id;
  final String nama;
  final String gambar;
  final String slug;
  final int jumlahLayanan;

  const ServiceCategoryModel({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.slug,
    required this.jumlahLayanan,
  });
  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryModelFromJson(json);

  @override
  List<Object?> get props => [id, nama, gambar];
}
