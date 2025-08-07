import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';

class FCLBaseDialog extends StatelessWidget {
  const FCLBaseDialog({
    required this.body,
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: UiConstants.spacing40),
    this.padding = const EdgeInsets.all(UiConstants.spacing24),
  });
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: margin,
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              borderRadius: UiConstants.borderRadiusLarge,
            ),
            child: Padding(padding: padding, child: body),
          ),
        ),
      ),
    );
  }
}
