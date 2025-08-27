import 'package:conf_ui_kit/src/chips/color_chip.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class SessionTrackChip extends StatelessWidget {
  const SessionTrackChip({required this.track, super.key});

  final int track;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return ColorChip(
      text: 'Track $track',
      backgroundColor: colorScheme.secondary,
      textColor: colorScheme.secondary,
    );
  }
}
