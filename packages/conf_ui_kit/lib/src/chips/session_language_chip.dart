import 'package:conf_shared_models/conf_shared_models.dart'
    show Language, LanguageX;
import 'package:conf_ui_kit/src/chips/color_chip.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class SessionLanguageChip extends StatelessWidget {
  const SessionLanguageChip({required this.language, super.key});

  final Language language;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return ColorChip(
      text: language.abbreviation,
      backgroundColor: colorScheme.secondary,
      textColor: colorScheme.secondary,
      icon: Icons.language,
    );
  }
}
