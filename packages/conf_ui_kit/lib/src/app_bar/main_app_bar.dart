import 'package:conf_ui_kit/src/app_bar/frosted_app_bar.dart';
import 'package:conf_ui_kit/src/constants/package_constants.dart';
import 'package:conf_ui_kit/src/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// An app bar that displays the conference logo and a profile button.
///
/// This component is typically used at the top of the main screens in the app
/// and provides access to user profile functionality.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    required this.profileLabel,
    required this.profileHint,
    required this.profileTooltip,
    required this.onProfileTap,
    super.key,
    this.avatar,
  });

  final String profileLabel;
  final String profileHint;
  final String profileTooltip;
  final VoidCallback onProfileTap;
  final Widget? avatar;

  Widget _buildLeadingLogo(BuildContext context) {
    final assets = context.appAssets;
    return SvgPicture.asset(
      assets.confLogoPath,
      package: PackageConstants.packageName,
    );
  }

  Widget _buildAvatar(ColorScheme colorScheme) {
    return Semantics(
      button: true,
      label: profileLabel,
      hint: profileHint,
      child: CircleAvatar(
        child: IconButton(
          tooltip: profileTooltip,
          icon: Icon(Icons.person_outline, color: colorScheme.onPrimary),
          onPressed: onProfileTap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return FrostedAppBar(
      automaticallyImplyLeading: false,
      leading: _buildLeadingLogo(context),
      actions: [avatar ?? _buildAvatar(colorScheme)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
