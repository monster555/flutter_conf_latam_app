// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sponsor _$SponsorFromJson(Map<String, dynamic> json) => Sponsor(
  level: $enumDecode(_$SponsorTierEnumMap, json['level']),
  logo: json['logo'] as String,
  name: json['name'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$SponsorToJson(Sponsor instance) => <String, dynamic>{
  'level': _$SponsorTierEnumMap[instance.level]!,
  'logo': instance.logo,
  'name': instance.name,
  'url': instance.url,
};

const _$SponsorTierEnumMap = {
  SponsorTier.platinum: 'platinum',
  SponsorTier.gold: 'gold',
  SponsorTier.silver: 'silver',
  SponsorTier.inKind: 'inKind',
  SponsorTier.senior: 'senior',
  SponsorTier.other: 'other',
};
