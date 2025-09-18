import 'package:conf_shared_models/conf_shared_models.dart' show SponsorTier;

extension SponsorTierX on SponsorTier {
  /// Converts a string to a SponsorTier enum value
  static SponsorTier fromString(String? value) => switch (value
      ?.toLowerCase()) {
    'platinum' => SponsorTier.platinum,
    'gold' => SponsorTier.gold,
    'silver' => SponsorTier.silver,
    'inkind' || 'inKind' => SponsorTier.inKind,
    'senior' => SponsorTier.senior,
    _ => SponsorTier.other,
  };

  int get sortPriority => switch (this) {
    SponsorTier.platinum => 1,
    SponsorTier.gold => 2,
    SponsorTier.silver => 3,
    SponsorTier.bronze => 4,
    SponsorTier.inKind => 5,
    SponsorTier.senior => 6,
    SponsorTier.junior => 7,
    SponsorTier.other => 8,
  };
}
