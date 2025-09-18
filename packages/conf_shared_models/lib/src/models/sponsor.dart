import 'package:conf_shared_models/src/converters/sponsor_tier_converter.dart';
import 'package:conf_shared_models/src/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sponsor.g.dart';

@JsonSerializable()
class Sponsor {
  const Sponsor({
    required this.level,
    required this.logo,
    required this.name,
    required this.url,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) =>
      _$SponsorFromJson(json);

  Map<String, dynamic> toJson() => _$SponsorToJson(this);

  @SponsorTierConverter()
  final SponsorTier level;
  final String logo;
  final String name;
  final String url;
}
