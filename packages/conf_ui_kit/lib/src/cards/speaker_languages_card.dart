import 'package:conf_ui_kit/src/constants/package_constants.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A card displaying information about languages a speaker knows.
///
/// Typically used in speaker profiles to encourage attendees to interact
/// with speakers in their preferred languages.
class SpeakerLanguagesCard extends StatelessWidget {
  /// Creates a card showing a speaker's languages.
  const SpeakerLanguagesCard({
    required this.promptText,
    required this.languagesPrefix,
    required this.languagesList,
    super.key,
  });

  /// Text prompting attendees to interact with the speaker.
  final String promptText;

  /// The prefix for the languages list.
  final String languagesPrefix;

  /// The languages the speaker knows, as a formatted string.
  final String languagesList;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    final semanticLabel = '$promptText $languagesPrefix $languagesList';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(UiConstants.spacing16),
        child: Semantics(
          label: semanticLabel,
          child: Row(
            children: [
              ExcludeSemantics(
                child: SvgPicture.asset(
                  'assets/images/waving_dash.svg',
                  package: PackageConstants.packageName,
                  placeholderBuilder:
                      (_) => const Icon(Icons.language, size: 48),
                ),
              ),
              const SizedBox(width: UiConstants.spacing8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(promptText, style: textTheme.titleMedium),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '$languagesPrefix ',
                            style: textTheme.titleMedium,
                          ),
                          TextSpan(
                            text: languagesList,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
