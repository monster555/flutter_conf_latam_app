import 'package:conf_ui_kit/src/effects/frosted_glass.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class ConferenceBottomNavigationBar extends StatelessWidget {
  const ConferenceBottomNavigationBar({
    required this.currentIndex,
    required this.onTabSelected,
    required this.itemsBuilder,
    this.semanticsLabel = 'Bottom Navigation Bar',
    this.semanticsHint = 'Tap a tab to navigate to a different section',
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final List<BottomNavigationBarItem> Function(BuildContext) itemsBuilder;
  final String semanticsLabel;
  final String semanticsHint;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Semantics(
      container: true,
      label: semanticsLabel,
      hint: semanticsHint,
      child: FrostedGlass(
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: onTabSelected,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: colorScheme.primary,
          unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.6),
          items: itemsBuilder(context),
        ),
      ),
    );
  }
}
