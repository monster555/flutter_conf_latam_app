import 'package:conf_shared_models/src/enums/enums.dart';
import 'package:conf_shared_models/src/models/social_media_link.dart';
import 'package:json_annotation/json_annotation.dart';

part 'speaker.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Speaker {
  Speaker({
    required this.id,
    required this.name,
    required this.photo,
    required this.company,
    required this.title,
    required this.description,
    required this.country,
    required this.countryCode,
    required this.countryFlagUrl,
    required this.socialMediaLinks,
    required this.languages,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) =>
      _$SpeakerFromJson(json);

  Map<String, dynamic> toJson() => _$SpeakerToJson(this);

  final String id;
  final String name;
  final String photo;
  final String company;
  final String title;
  final String description;
  final String country;
  final String countryCode;
  @JsonKey(name: 'country_flag')
  final String countryFlagUrl;
  final List<Language> languages;
  final List<SocialMediaLink> socialMediaLinks;
}
