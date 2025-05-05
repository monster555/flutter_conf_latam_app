// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speaker _$SpeakerFromJson(Map<String, dynamic> json) => Speaker(
  id: json['id'] as String,
  name: json['name'] as String,
  photo: json['photo'] as String,
  company: json['company'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  country: json['country'] as String,
  countryCode: json['country_code'] as String,
  socialMediaLinks:
      (json['social_media_links'] as List<dynamic>)
          .map((e) => SocialMediaLink.fromJson(e as Map<String, dynamic>))
          .toList(),
  languages:
      (json['languages'] as List<dynamic>)
          .map((e) => $enumDecode(_$LanguageEnumMap, e))
          .toList(),
);

Map<String, dynamic> _$SpeakerToJson(Speaker instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'photo': instance.photo,
  'company': instance.company,
  'title': instance.title,
  'description': instance.description,
  'country': instance.country,
  'country_code': instance.countryCode,
  'languages': instance.languages.map((e) => _$LanguageEnumMap[e]!).toList(),
  'social_media_links': instance.socialMediaLinks,
};

const _$LanguageEnumMap = {
  Language.spanish: 'spanish',
  Language.english: 'english',
};
