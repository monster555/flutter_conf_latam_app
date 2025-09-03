import 'package:conf_shared_models/src/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'speaker_summary.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SpeakerSummary {
  SpeakerSummary({
    required this.id,
    required this.name,
    required this.photo,
    required this.title,
    required this.country,
    required this.countryCode,
    required this.countryFlagUrl,
    required this.languages,
  });

  factory SpeakerSummary.fromJson(Map<String, dynamic> json) =>
      _$SpeakerSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakerSummaryToJson(this);

  final String id;
  final String name;
  final String photo;
  final String title;
  final String country;
  final String countryCode;
  @JsonKey(name: 'country_flag')
  final String countryFlagUrl;
  final List<Language> languages;
}
