import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:conf_ui_kit/src/utils/date_format_service.dart';
import 'package:flutter/material.dart';

class DatesTabs extends StatelessWidget {
  const DatesTabs({
    required this.availableDates,
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });
  final List<DateTime> availableDates;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  // Compare dates ignoring time
  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    if (availableDates.isEmpty) {
      return const SizedBox.shrink();
    }

    return Semantics(
      container: true,
      label: 'Conference dates',
      hint: 'Select a date to view the schedule',
      child: Row(
        children:
            availableDates.map((date) {
              final isSelected = _isSameDay(date, selectedDate);
              final isLastItem = date == availableDates.last;

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: isLastItem ? 0 : UiConstants.spacing8,
                  ),
                  child: _DateTab(
                    date: date,
                    isSelected: isSelected,
                    onTap: () => onDateSelected(date),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}

class _DateTab extends StatelessWidget {
  const _DateTab({
    required this.date,
    required this.isSelected,
    required this.onTap,
  });
  static const _borderRadius = BorderRadius.all(
    Radius.circular(UiConstants.radiusLarge),
  );

  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  (Color backgroundColor, Color textColor, FontWeight fontWeight) _getStyles(
    bool isSelected,
    ColorScheme colorScheme,
  ) {
    final backgroundColor =
        isSelected
            ? colorScheme.primary.withValues(alpha: 0.2)
            : Colors.transparent;
    final textColor = isSelected ? colorScheme.primary : colorScheme.onSurface;
    final fontWeight = isSelected ? FontWeight.bold : FontWeight.normal;

    return (backgroundColor, textColor, fontWeight);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    final formatter = DateFormatService.withContext(context);
    final formattedDate = formatter.formatTabDate(date);

    final (backgroundColor, textColor, fontWeight) = _getStyles(
      isSelected,
      colorScheme,
    );

    return Semantics(
      label: formattedDate,
      selected: isSelected,
      button: true,
      hint: isSelected ? 'Current date' : 'Tap to view this date',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: _borderRadius,
          child: AnimatedContainer(
            duration: UiConstants.animationShort,
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              color: backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: UiConstants.spacing12,
              ),
              child: Center(
                child: Text(
                  formattedDate,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: fontWeight,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
