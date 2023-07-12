// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListServiceModel _$ListServiceModelFromJson(Map<String, dynamic> json) =>
    ListServiceModel(
      message: json['message'] as String,
      kategoriLayanan: json['kategori_layanan'] as String,
      layananAll: (json['layanan_all'] as List<dynamic>)
          .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      id: json['id'] as int,
      nama: json['nama'] as String,
      slug: json['slug'] as String,
      harga: json['harga'] as String,
      deskripsi: json['deskripsi'] as String?,
      status: json['status'] as bool,
    );
