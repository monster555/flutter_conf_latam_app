import 'package:conf_shared_models/src/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

class SponsorTierConverter implements JsonConverter<SponsorTier, String?> {
  const SponsorTierConverter();

  @override
  SponsorTier fromJson(String? json) {
    if (json == null) return SponsorTier.other;

    final normalized = json.toLowerCase().trim();

    return switch (normalized) {
      'platinum' => SponsorTier.platinum,
      'gold' => SponsorTier.gold,
      'silver' => SponsorTier.silver,
      'bronze' => SponsorTier.bronze,
      'inkind' || 'inKind' => SponsorTier.inKind,
      'senior' => SponsorTier.senior,
      'junior' => SponsorTier.junior,
      _ => SponsorTier.other,
    };
  }

  @override
  String? toJson(SponsorTier? tier) => tier?.name;
}
