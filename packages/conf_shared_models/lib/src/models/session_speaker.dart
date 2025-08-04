import 'package:json_annotation/json_annotation.dart';

part 'session_speaker.g.dart';

@JsonSerializable()
class SessionSpeaker {
  const SessionSpeaker({
    required this.id,
    required this.name,
    required this.title,
    required this.imageUrl,
  });

  factory SessionSpeaker.fromJson(Map<String, dynamic> json) =>
      _$SessionSpeakerFromJson(json);

  Map<String, dynamic> toJson() => _$SessionSpeakerToJson(this);

  final String id;
  final String name;
  final String title;
  final String imageUrl;
}
