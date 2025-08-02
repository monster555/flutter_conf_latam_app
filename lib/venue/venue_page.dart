import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/utils/external_link.dart';

class VenuePage extends StatelessWidget {
  const VenuePage({super.key});

  static const String imagePath = 'assets/images/udla.webp';
  static const String venueName = 'Universidad de las Américas';
  static const String venueAddress = 'Vía a Nayón, Quito';
  static const double venueLatitude = -0.162342183708216;
  static const double venueLongitude = -78.4587568998666;
  static const String venueCapacity = '600';

  Widget _buildDirectionsButton({
    required ColorScheme colorScheme,
    required AppLocalizations l10n,
    required VoidCallback onTap,
  }) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(vertical: UiConstants.spacing12),
    );

    return Padding(
      padding: const EdgeInsets.only(top: UiConstants.spacing16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.directions),
          label: Text(l10n.actionGetDirections),
          style: buttonStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = context.colorScheme;
    final padding = context.padding;

    // Get all venue info sections
    final venueInfoSections = [
      InfoSection(
        title: l10n.facilitiesCampusTitle,
        description: l10n.facilitiesCampusDescription,
        icon: Icons.school,
      ),
      InfoSection(
        title: l10n.facilitiesFoodTitle,
        description: l10n.facilitiesFoodDescription,
        icon: Icons.restaurant,
      ),
      InfoSection(
        title: l10n.navigatingCampusTitle,
        description: l10n.navigatingCampusDescription,
        icon: Icons.map,
      ),
      InfoSection(
        title: l10n.sectionTitleAccessibility,
        description: l10n.accessibilityDescription,
        icon: Icons.accessible,
      ),
    ];

    final venueDetails = [
      const IconLabelItem(text: venueAddress, icon: Icons.location_on_outlined),
      IconLabelItem(
        text: l10n.venueCapacity(venueCapacity),
        icon: Icons.people_outline,
      ),
    ];

    return Semantics(
      container: true,
      label: l10n.venueTabLabel,
      explicitChildNodes: true,
      child: Scaffold(
        appBar: const FrostedAppBar(),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: UiConstants.spacing16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FeatureImage(
                        imagePath: imagePath,
                        semanticLabel: l10n.imageVenueDescription,
                      ),
                      const SectionTitle(
                        title: venueName,
                        padding: EdgeInsets.only(
                          top: UiConstants.spacing16,
                          bottom: UiConstants.spacing8,
                        ),
                      ),
                      IconLabelList(items: venueDetails),
                      _buildDirectionsButton(
                        l10n: l10n,
                        onTap:
                            () => ExternalLinkUtil.openMap(
                              venueLatitude,
                              venueLongitude,
                            ),
                        colorScheme: colorScheme,
                      ),
                    ],
                  ),
                ),

                InfoSectionGroup(
                  title: l10n.sectionTitleVenue,
                  sections: venueInfoSections,
                ),

                ExcludeSemantics(child: SizedBox(height: padding.bottom)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
