import 'package:conf_ui_kit/src/theme/app_assets.dart';
import 'package:conf_ui_kit/src/theme/app_colors.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static final lightTheme = ThemeData(
    extensions: const [AppAssets.light],
    brightness: Brightness.light,
    primaryColor: AppColors.flutterNavy,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.lightText,
      displayColor: AppColors.lightText,
    ),
    colorScheme: AppColors.lightColorScheme(),
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.flutterBlue.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: UiConstants.borderRadiusLarge,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.flutterNavy,
        highlightColor: AppColors.flutterNavy.withValues(alpha: 0.1),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.flutterNavy,
        side: BorderSide(color: AppColors.flutterNavy.withValues(alpha: 0.3)),
      ),
    ),
    splashColor: AppColors.flutterBlue.withValues(alpha: 0.2),
    highlightColor: AppColors.flutterBlue.withValues(alpha: 0.1),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    extensions: const [AppAssets.dark],
    brightness: Brightness.dark,
    primaryColor: AppColors.flutterBlue,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: AppColors.darkText, displayColor: AppColors.darkText),

    colorScheme: AppColors.darkColorScheme(),
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.flutterNavy.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: UiConstants.borderRadiusLarge,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.flutterBlue,
        highlightColor: AppColors.flutterBlue.withValues(alpha: 0.1),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.flutterBlue,
        side: BorderSide(color: AppColors.flutterBlue.withValues(alpha: 0.3)),
      ),
    ),
    splashColor: AppColors.flutterSky.withValues(alpha: 0.2),
    highlightColor: AppColors.flutterSky.withValues(alpha: 0.1),
  );
}
