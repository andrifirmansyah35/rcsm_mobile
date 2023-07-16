import 'package:json_annotation/json_annotation.dart';

enum ReservationStatusType {
  @JsonValue('antri')
  antri,
  @JsonValue('diproses')
  diproses,
  @JsonValue('selesai')
  selesai,
  @JsonValue('dibatalkan')
  dibatalkan,
  @JsonValue('tidak datang')
  tidakDatang,
}
