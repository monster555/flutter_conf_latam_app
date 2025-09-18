// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sponsor _$SponsorFromJson(Map<String, dynamic> json) => Sponsor(
  level: const SponsorTierConverter().fromJson(json['level'] as String?),
  logo: json['logo'] as String,
  name: json['name'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$SponsorToJson(Sponsor instance) => <String, dynamic>{
  'level': const SponsorTierConverter().toJson(instance.level),
  'logo': instance.logo,
  'name': instance.name,
  'url': instance.url,
};
