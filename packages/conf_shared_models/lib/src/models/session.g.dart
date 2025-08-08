// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
  id: json['id'] as String,
  title: json['title'] as String,
  type: $enumDecode(_$SessionTypeEnumMap, json['type']),
  track: (json['track'] as num).toInt(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  language: $enumDecode(_$LanguageEnumMap, json['language']),
  description: json['description'] as String?,
  level: $enumDecodeNullable(_$SessionLevelEnumMap, json['level']),
  speakers:
      (json['speakers'] as List<dynamic>?)
          ?.map((e) => SessionSpeaker.fromJson(e as Map<String, dynamic>))
          .toList(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  requirements:
      (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
);

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': _$SessionTypeEnumMap[instance.type]!,
  'track': instance.track,
  'level': _$SessionLevelEnumMap[instance.level],
  'language': _$LanguageEnumMap[instance.language]!,
  'speakers': instance.speakers,
  'tags': instance.tags,
  'requirements': instance.requirements,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
};

const _$SessionTypeEnumMap = {
  SessionType.checkIn: 'checkIn',
  SessionType.keynote: 'keynote',
  SessionType.session: 'session',
  SessionType.breakTime: 'breakTime',
  SessionType.workshop: 'workshop',
  SessionType.breaks: 'breaks',
};

const _$LanguageEnumMap = {
  Language.spanish: 'spanish',
  Language.english: 'english',
};

const _$SessionLevelEnumMap = {
  SessionLevel.basic: 'basic',
  SessionLevel.intermediate: 'intermediate',
  SessionLevel.advanced: 'advanced',
  SessionLevel.expert: 'expert',
};
