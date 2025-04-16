import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';

class AgendaHeader extends StatelessWidget {
  const AgendaHeader({
    required this.availableDates,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onFavoriteTap,
    required this.favoriteSessionsLabel,
    required this.favoriteSessionsTooltip,
    super.key,
  });

  final List<DateTime> availableDates;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onFavoriteTap;
  final String favoriteSessionsLabel;
  final String favoriteSessionsTooltip;

  Widget _buildDateTabs() {
    return Expanded(
      child: DatesTabs(
        availableDates: availableDates,
        selectedDate: selectedDate,
        onDateSelected: onDateSelected,
      ),
    );
  }

  Widget _buildVerticalDivider(Color borderColor) {
    return ExcludeSemantics(
      child: SizedBox(
        height: UiConstants.spacing24,
        child: VerticalDivider(color: borderColor, width: 16, thickness: 1),
      ),
    );
  }

  Widget _buildFavoritesButton(Color iconColor, Color borderColor) {
    return Semantics(
      label: favoriteSessionsLabel,
      button: true,
      enabled: true,
      child: IconButton(
        tooltip: favoriteSessionsTooltip,
        style: IconButton.styleFrom(side: BorderSide(color: borderColor)),
        icon: Icon(
          Icons.favorite_border,
          size: UiConstants.iconSizeMedium,
          color: iconColor,
        ),
        onPressed: onFavoriteTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final iconColor = colorScheme.primary;
    final borderColor = colorScheme.primary.withValues(alpha: 0.3);

    return SafeArea(
      bottom: false,
      child: FrostedGlass(
        child: Padding(
          padding: const EdgeInsets.only(
            left: UiConstants.spacing16,
            right: UiConstants.spacing12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  _buildDateTabs(),
                  _buildVerticalDivider(borderColor),
                  _buildFavoritesButton(iconColor, borderColor),
                ],
              ),
              const SizedBox(height: UiConstants.spacing8),
            ],
          ),
        ),
      ),
    );
  }
}
