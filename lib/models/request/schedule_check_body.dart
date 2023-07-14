import 'package:json_annotation/json_annotation.dart';

part 'schedule_check_body.g.dart';

@JsonSerializable(createFactory: false)
class ScheduleCheckBody {
  final String tahun;
  final String bulan;
  final String hari;

  const ScheduleCheckBody({
    required this.tahun,
    required this.bulan,
    required this.hari,
  });

  Map<String, dynamic> toJson() => _$ScheduleCheckBodyToJson(this);
}
