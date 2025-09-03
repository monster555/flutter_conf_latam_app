// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeakerSummary _$SpeakerSummaryFromJson(Map<String, dynamic> json) =>
    SpeakerSummary(
      id: json['id'] as String,
      name: json['name'] as String,
      photo: json['photo'] as String,
      title: json['title'] as String,
      country: json['country'] as String,
      countryCode: json['country_code'] as String,
      countryFlagUrl: json['country_flag'] as String,
      languages: (json['languages'] as List<dynamic>)
          .map((e) => $enumDecode(_$LanguageEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$SpeakerSummaryToJson(
  SpeakerSummary instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'photo': instance.photo,
  'title': instance.title,
  'country': instance.country,
  'country_code': instance.countryCode,
  'country_flag': instance.countryFlagUrl,
  'languages': instance.languages.map((e) => _$LanguageEnumMap[e]!).toList(),
};

const _$LanguageEnumMap = {
  Language.spanish: 'spanish',
  Language.english: 'english',
};
