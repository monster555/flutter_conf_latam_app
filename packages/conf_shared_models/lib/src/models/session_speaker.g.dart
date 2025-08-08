// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_speaker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionSpeaker _$SessionSpeakerFromJson(Map<String, dynamic> json) =>
    SessionSpeaker(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$SessionSpeakerToJson(SessionSpeaker instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };
