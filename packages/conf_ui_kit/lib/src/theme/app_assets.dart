import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Theme extension that provides access to theme-dependent assets.
///
/// This extension allows UI components to automatically adapt to the current
/// theme by providing the correct asset paths based on light or dark mode.
class AppAssets extends ThemeExtension<AppAssets> {
  /// Creates an instance of [AppAssets] with the specified asset paths.
  const AppAssets({required this.confLogoPath, required this.logo});

  /// Path to the conference logo SVG asset.
  final String confLogoPath;
  final SvgPicture logo;

  @override
  ThemeExtension<AppAssets> copyWith({String? confLogoPath, SvgPicture? logo}) {
    return AppAssets(
      confLogoPath: confLogoPath ?? this.confLogoPath,
      logo: logo ?? this.logo,
    );
  }

  @override
  ThemeExtension<AppAssets> lerp(covariant AppAssets? other, double t) => this;

  /// Light theme assets
  static final light = AppAssets(
    confLogoPath: 'assets/icons/flutter_conf_logo_light.svg',
    logo: Assets.brand.fclLight.svg(),
  );

  /// Dark theme assets
  static final dark = AppAssets(
    confLogoPath: 'assets/icons/flutter_conf_logo_dark.svg',
    logo: Assets.brand.fclDark.svg(),
  );
}
