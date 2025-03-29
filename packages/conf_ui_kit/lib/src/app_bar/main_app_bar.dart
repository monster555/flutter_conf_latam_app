import 'package:conf_ui_kit/src/app_bar/frosted_app_bar.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final headlineSmallStyle = context.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
    );

    final title = Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'FlutterConf', style: headlineSmallStyle),
          TextSpan(
            text: ' Latam',
            style: headlineSmallStyle?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );

    final avatar = Semantics(
      button: true,
      label: 'User profile',
      child: CircleAvatar(
        child: IconButton(
          icon: const Icon(Icons.person_outline),
          onPressed: () {},
        ),
      ),
    );

    return FrostedAppBar(
      automaticallyImplyLeading: false,
      title: title,
      actions: [avatar],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
