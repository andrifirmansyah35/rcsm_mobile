import 'package:json_annotation/json_annotation.dart';

part 'slug_body.g.dart';

@JsonSerializable(createFactory: false)
class SlugBody {
  final String slugLayanan;

  const SlugBody({
    required this.slugLayanan,
  });

  Map<String, dynamic> toJson() => _$SlugBodyToJson(this);
}
