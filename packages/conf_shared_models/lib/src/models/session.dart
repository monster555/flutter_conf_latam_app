import 'package:conf_shared_models/src/enums/enums.dart';
import 'package:conf_shared_models/src/models/speaker.dart';

class Session {
  Session({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.track,
    required this.level,
    required this.mainSpeaker,
    required this.language,
    this.coSpeakers,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      level: SessionLevel.values.byName(json['level'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      track: json['track'] as String,
      mainSpeaker: Speaker.fromJson(
        json['mainSpeaker'] as Map<String, dynamic>,
      ),
      coSpeakers:
          (json['coSpeakers'] as List<Map<String, dynamic>>?)
              ?.map(Speaker.fromJson)
              .toList(),
      language: Language.values.byName(json['language'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'level': level.name,
      'mainSpeaker': mainSpeaker.toJson(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'track': track,
      'language': language.name,
    };
  }

  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String track;
  final SessionLevel level;
  final Speaker mainSpeaker;
  final List<Speaker>? coSpeakers;
  final Language language;
}
