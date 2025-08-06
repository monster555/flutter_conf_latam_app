import 'package:conf_ui_kit/src/theme/app_assets.dart';
import 'package:conf_ui_kit/src/theme/color_chip_theme.dart';
import 'package:flutter/material.dart';

extension ThemeX on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  AppAssets get appAssets =>
      Theme.of(this).extension<AppAssets>() ?? AppAssets.light;

  ColorChipTheme get colorChipTheme =>
      Theme.of(this).extension<ColorChipTheme>() ?? ColorChipTheme.light;
}
