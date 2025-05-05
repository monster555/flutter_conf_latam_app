import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';

/// A sticky header component designed for the agenda view.
///
/// This component is specifically intended to be used with [SliverPinnedHeader]
/// in the agenda page to create a persistent date selection bar that remains
/// visible while scrolling through session content.
class AgendaHeader extends StatelessWidget {
  const AgendaHeader({
    required this.availableDates,
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });

  final List<DateTime> availableDates;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: FrostedGlass(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: UiConstants.spacing16,
            vertical: UiConstants.spacing8,
          ),
          child: Row(
            children: [
              Expanded(
                child: DatesTabs(
                  availableDates: availableDates,
                  selectedDate: selectedDate,
                  onDateSelected: onDateSelected,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
