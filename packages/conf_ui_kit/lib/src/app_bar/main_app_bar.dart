import 'package:conf_ui_kit/src/app_bar/frosted_app_bar.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    required this.profileLabel,
    required this.profileHint,
    required this.profileTooltip,
    super.key,
  });

  final String profileLabel;
  final String profileHint;
  final String profileTooltip;

  Widget _buildAppTitle(TextTheme textTheme, ColorScheme colorScheme) {
    final headlineSmallStyle = textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'FlutterConf', style: headlineSmallStyle),
          TextSpan(
            text: ' Latam',
            style: headlineSmallStyle?.copyWith(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(ColorScheme colorScheme) {
    return Semantics(
      button: true,
      label: 'User profile',
      child: CircleAvatar(
        child: IconButton(
          icon: Icon(Icons.person_outline, color: colorScheme.onPrimary),
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return FrostedAppBar(
      automaticallyImplyLeading: false,
      title: _buildAppTitle(textTheme, colorScheme),
      actions: [_buildAvatar(colorScheme)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
