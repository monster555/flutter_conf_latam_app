import 'package:conf_shared_models/conf_shared_models.dart' show SessionLevel;
import 'package:conf_ui_kit/src/chips/color_chip.dart';
import 'package:conf_ui_kit/src/extensions/session_level_extensions.dart';
import 'package:flutter/material.dart';

class SessionLevelChip extends StatelessWidget {
  const SessionLevelChip({
    required this.level,
    required this.labelText,
    super.key,
  });

  final SessionLevel level;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return ColorChip(
      text: labelText,
      backgroundColor: level.color,
      textColor: level.color,
    );
  }
}
