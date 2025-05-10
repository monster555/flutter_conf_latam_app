import 'package:flutter/material.dart';

/// Theme extension that provides access to theme-dependent assets.
///
/// This extension allows UI components to automatically adapt to the current
/// theme by providing the correct asset paths based on light or dark mode.
class AppAssets extends ThemeExtension<AppAssets> {
  /// Creates an instance of [AppAssets] with the specified asset paths.
  const AppAssets({required this.confLogoPath});

  /// Path to the conference logo SVG asset.
  final String confLogoPath;

  @override
  ThemeExtension<AppAssets> copyWith({String? confLogoPath}) {
    return AppAssets(confLogoPath: confLogoPath ?? this.confLogoPath);
  }

  @override
  ThemeExtension<AppAssets> lerp(covariant AppAssets? other, double t) => this;

  /// Light theme assets
  static const light = AppAssets(
    confLogoPath: 'assets/icons/flutter_conf_logo_light.svg',
  );

  /// Dark theme assets
  static const dark = AppAssets(
    confLogoPath: 'assets/icons/flutter_conf_logo_dark.svg',
  );
}
