// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCategoryResponseModel _$ServiceCategoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    ServiceCategoryResponseModel(
      json['message'] as String,
      (json['kategori_layanan'] as List<dynamic>)
          .map((e) => ServiceCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ServiceCategoryModel _$ServiceCategoryModelFromJson(
        Map<String, dynamic> json) =>
    ServiceCategoryModel(
      id: json['id'] as int,
      nama: json['nama'] as String,
      gambar: json['gambar'] as String,
      slug: json['slug'] as String,
      jumlahLayanan: json['jumlah_layanan'] as int,
    );
