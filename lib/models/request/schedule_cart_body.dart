import 'package:json_annotation/json_annotation.dart';

part 'schedule_cart_body.g.dart';

@JsonSerializable(createFactory: false)
class ScheduleCartBody {
  final String idOperasi;

  const ScheduleCartBody({
    required this.idOperasi,
  });

  Map<String, dynamic> toJson() => _$ScheduleCartBodyToJson(this);
}
