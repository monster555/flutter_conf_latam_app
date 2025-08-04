import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';

class SlotHeader extends StatelessWidget {
  const SlotHeader({required this.timeSlot, super.key});

  final TimeSlot timeSlot;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return Semantics(
      header: true,
      label: 'Time slot ${timeSlot.name}',
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: UiConstants.spacing16,
            vertical: UiConstants.spacing4,
          ),
          child: Text(
            timeSlot.name,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
