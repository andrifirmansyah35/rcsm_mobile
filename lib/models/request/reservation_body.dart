
import 'package:json_annotation/json_annotation.dart';

part 'reservation_body.g.dart';

@JsonSerializable(createFactory: false)
class ReservationBody {
  final String idLayanan;
  final String idOperasi;

  const ReservationBody({
    required this.idLayanan,
    required this.idOperasi,
  });

  Map<String, dynamic> toJson() => _$ReservationBodyToJson(this);
}
