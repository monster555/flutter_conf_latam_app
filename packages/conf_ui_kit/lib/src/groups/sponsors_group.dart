import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/images/sponsor_logo.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:conf_ui_kit/src/typography/section_title.dart';
import 'package:flutter/material.dart';

/// A group of sponsors with a section title.
///
/// Displays a section title followed by a list of sponsor logos.
class SponsorsGroup extends StatelessWidget {
  /// Creates a group of sponsors with a section title.
  const SponsorsGroup({
    required this.title,
    required this.sponsors,
    this.titlePadding = const EdgeInsets.fromLTRB(
      UiConstants.spacing16,
      UiConstants.spacing16,
      UiConstants.spacing16,
      UiConstants.spacing8,
    ),
    this.sponsorPadding = const EdgeInsets.fromLTRB(
      UiConstants.spacing16,
      0,
      UiConstants.spacing16,
      UiConstants.spacing16,
    ),
    super.key,
  });

  /// The title of the sponsor tier.
  final String title;

  /// The list of sponsors in this tier.
  final List<Sponsor> sponsors;

  /// Padding for the section title.
  final EdgeInsets titlePadding;

  /// Padding for each sponsor logo.
  final EdgeInsets sponsorPadding;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: title,
      explicitChildNodes: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title, padding: titlePadding),
          ...sponsors.map(
            (sponsor) => Padding(
              padding: sponsorPadding,
              child: SponsorLogo(
                imageUrl: sponsor.logo,
                sponsorName: sponsor.name,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
