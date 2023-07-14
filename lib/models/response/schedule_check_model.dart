import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_check_model.g.dart';

@JsonSerializable(createToJson: false)
class ScheduleCheckModel extends Equatable {
  final String message;
  final List<OperasionalModel> operasional;

  const ScheduleCheckModel({
    required this.message,
    this.operasional = const [],
  });

  factory ScheduleCheckModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleCheckModelFromJson(json);

  @override
  List<Object?> get props => [
        message,
        operasional,
      ];
}

@JsonSerializable(createToJson: false)
class OperasionalModel extends Equatable {
  final int id;
  final int jadwalOperasiId;
  final String waktuMulai;
  final bool status;
  final String waktuSelesai;

  const OperasionalModel({
    required this.id,
    required this.jadwalOperasiId,
    required this.status,
    required this.waktuMulai,
    required this.waktuSelesai,
  });

  factory OperasionalModel.fromJson(Map<String, dynamic> json) =>
      _$OperasionalModelFromJson(json);

  @override
  List<Object?> get props => [
        id,
        jadwalOperasiId,
        status,
        waktuMulai,
        waktuSelesai,
      ];
}
