import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_cart_model.g.dart';

@JsonSerializable(createToJson: false)
class ListScheduleCartModel extends Equatable {
  final List<ScheduleCartModel> keranjangOperasiBuka;
  final List<ScheduleCartModel> keranjangOperasiTerblokir;

  const ListScheduleCartModel({
    required this.keranjangOperasiBuka,
    required this.keranjangOperasiTerblokir,
  });

  factory ListScheduleCartModel.fromJson(Map<String, dynamic> json) =>
      _$ListScheduleCartModelFromJson(json);

  @override
  List<Object?> get props => [
        keranjangOperasiBuka,
        keranjangOperasiTerblokir,
      ];
}

@JsonSerializable(createToJson: false)
class ScheduleCartModel extends Equatable {
  final int id;
  final bool status;
  final int userId;
  final String userNama;
  final String operasi;
  final String jadwalOperasi;

  const ScheduleCartModel({
    required this.id,
    required this.status,
    required this.userId,
    required this.userNama,
    required this.operasi,
    required this.jadwalOperasi,
  });

  factory ScheduleCartModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleCartModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        status,
        userId,
        userNama,
        operasi,
        jadwalOperasi,
      ];
}
