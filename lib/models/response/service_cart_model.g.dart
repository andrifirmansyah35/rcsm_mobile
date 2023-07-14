// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListServiceCartModel _$ListServiceCartModelFromJson(
        Map<String, dynamic> json) =>
    ListServiceCartModel(
      dataKeranjangLayananOpen:
          (json['data_keranjang_layanan_open'] as List<dynamic>)
              .map((e) => ServiceCartModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      dataKeranjangClose: (json['data_keranjang_close'] as List<dynamic>)
          .map((e) => ServiceCartModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ServiceCartModel _$ServiceCartModelFromJson(Map<String, dynamic> json) =>
    ServiceCartModel(
      idKeranjangLayanan: json['id_keranjang_layanan'] as int,
      idLayanan: json['id_layanan'] as int,
      status: json['status'] as bool,
      layanan: json['layanan'] as String,
      gambarKategoriLayanan: json['gambar_kategori_layanan'] as String,
      kategoriLayanan: json['kategori_layanan'] as String,
      harga: json['harga'] as String,
    );
