import 'package:conf_ui_kit/src/theme/app_assets.dart';
import 'package:conf_ui_kit/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

extension ThemeX on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  AppAssets get appAssets {
    return Theme.of(this).extension<AppAssets>() ?? AppAssets.light;
  }

  bool get dark => colorScheme.brightness == Brightness.dark;

  TextStyle? get primaryButton {
    final bodyMedium = textTheme.bodyMedium;
    return switch (dark) {
      true => bodyMedium?.copyWith(color: AppColors.lightText),
      false => bodyMedium?.copyWith(color: AppColors.onPrimary),
    };
  }

  TextStyle? get secondaryButton => switch (dark) {
    true => textTheme.bodyMedium?.copyWith(color: AppColors.onPrimary),
    false => null,
  };

  Color get primaryButtonColor => switch (dark) {
    true => AppColors.onPrimary,
    false => AppColors.onPrimaryDark,
  };

  Color get primaryButtonOverlayColor => switch (dark) {
    true => AppColors.onPrimaryDark,
    false => AppColors.onPrimary,
  };
}
