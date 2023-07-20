import 'package:json_annotation/json_annotation.dart';

part 'delete_service_cart_body.g.dart';

@JsonSerializable(createFactory: false)
class DeleteServiceCartBody {
  final String idKeranjangLayanan;

  const DeleteServiceCartBody({
    required this.idKeranjangLayanan,
  });

  Map<String, dynamic> toJson() => _$DeleteServiceCartBodyToJson(this);
}
