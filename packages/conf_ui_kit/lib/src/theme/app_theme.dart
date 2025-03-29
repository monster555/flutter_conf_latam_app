import 'package:conf_ui_kit/src/theme/app_colors.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.flutterBlue,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.lightText,
      displayColor: AppColors.lightText,
    ),
    colorScheme: AppColors.lightColorScheme(),
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.lightCardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: UiConstants.borderRadiusLarge,
      ),
    ),
    splashColor: AppColors.flutterBlue.withValues(alpha: 0.2),
    highlightColor: AppColors.flutterBlue.withValues(alpha: 0.1),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.flutterLightBlue,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ).apply(bodyColor: AppColors.darkText, displayColor: AppColors.darkText),

    colorScheme: AppColors.darkColorScheme(),
    cardTheme: CardTheme(
      elevation: 0,
      color: AppColors.darkCardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: UiConstants.borderRadiusLarge,
      ),
    ),
    splashColor: AppColors.flutterLightBlue.withValues(alpha: 0.2),
    highlightColor: AppColors.flutterLightBlue.withValues(alpha: 0.1),
  );
}
