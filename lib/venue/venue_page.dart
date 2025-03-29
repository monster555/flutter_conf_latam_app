import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class VenuePage extends StatelessWidget {
  const VenuePage({super.key});

  static const String imagePath = 'assets/images/udla.webp';
  static const String venueName = 'Universidad de las Américas';
  static const String venueAddress = 'Vía a Nayón, Quito';
  static const String venueCoordinates = '-0.162342183708216,-78.4587568998666';
  static const String venueCapacity = '600';

  Future<void> _openMaps(BuildContext context) async {
    final url = Uri.parse('https://maps.google.com/?q=$venueCoordinates');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      // Show an error if unable to launch maps
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.errorMapsOpen)));
      }
    }
  }

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
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              ExcludeSemantics(child: SizedBox(height: padding.top)),

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
                      onTap: () => _openMaps(context),
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
    );
  }
}
