import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';

class DialogPage<T> extends Page<T> {
  const DialogPage({
    required this.builder,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    super.canPop,
    super.onPopInvoked,
    this.anchorPoint,
    this.barrierColor,
    this.barrierLabel,
    this.themes,
    this.barrierDismissible = true,
    this.useSafeArea = true,
  });

  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  @override
  Route<T> createRoute(BuildContext context) {
    var barrierColor = this.barrierColor;
    barrierColor ??= context.colorScheme.primary.withValues(alpha: .3);
    return DialogRoute<T>(
      context: context,
      settings: this,
      builder: builder,
      anchorPoint: anchorPoint,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      themes: themes,
    );
  }
}
