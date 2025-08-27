import 'package:conf_shared_models/src/converters/session_level_converter.dart';
import 'package:conf_shared_models/src/converters/session_type_converter.dart';
import 'package:conf_shared_models/src/enums/enums.dart';
import 'package:conf_shared_models/src/models/session_speaker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  const Session({
    required this.id,
    required this.title,
    required this.type,
    required this.track,
    required this.startDate,
    required this.endDate,
    this.language,
    this.description,
    this.level,
    this.speakers,
    this.tags,
    this.requirements,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  final String id;
  final String title;
  final String? description;

  @SessionTypeConverter()
  final SessionType type;
  final int track;

  @SessionLevelConverter()
  final SessionLevel? level;
  final Language? language;
  final List<SessionSpeaker>? speakers;
  final List<String>? tags;
  final List<String>? requirements;
  final DateTime startDate;
  final DateTime endDate;
}
