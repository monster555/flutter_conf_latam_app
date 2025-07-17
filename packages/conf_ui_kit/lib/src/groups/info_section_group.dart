import 'package:conf_ui_kit/src/cards/info_card.dart';
import 'package:conf_ui_kit/src/models/info_section.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:conf_ui_kit/src/typography/section_title.dart';
import 'package:flutter/material.dart';

/// A group of info cards with a section title.
///
/// Displays a section title followed by a list of info cards.
class InfoSectionGroup extends StatelessWidget {
  /// Creates a group of info cards with a section title.
  const InfoSectionGroup({
    required this.title,
    required this.sections,
    this.titlePadding = const EdgeInsets.fromLTRB(
      UiConstants.spacing16,
      UiConstants.spacing16,
      UiConstants.spacing16,
      UiConstants.spacing8,
    ),
    this.cardPadding = const EdgeInsets.fromLTRB(
      UiConstants.spacing16,
      0,
      UiConstants.spacing16,
      UiConstants.spacing16,
    ),
    super.key,
  });

  /// The title of the section.
  final String title;

  /// The list of info sections to display as cards.
  final List<InfoSection> sections;

  /// Padding for the section title.
  final EdgeInsets titlePadding;

  /// Padding for each info card.
  final EdgeInsets cardPadding;

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
          ...sections.map(
            (section) => Padding(
              padding: cardPadding,
              child: InfoCard(
                title: section.title,
                description: section.description,
                icon: section.icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
