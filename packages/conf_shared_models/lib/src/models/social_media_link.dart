import 'package:json_annotation/json_annotation.dart';

part 'social_media_link.g.dart';

@JsonSerializable()
class SocialMediaLink {
  SocialMediaLink({required this.link, required this.type});

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaLinkFromJson(json);

  Map<String, dynamic> toJson() => _$SocialMediaLinkToJson(this);

  final String link;
  final String type;
}
