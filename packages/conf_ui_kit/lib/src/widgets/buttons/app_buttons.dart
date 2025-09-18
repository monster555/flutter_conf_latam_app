import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';

class AppBaseButton extends StatelessWidget {
  const AppBaseButton({
    required this.child,
    required this.color,
    this.onPressed,
    super.key,
    this.borderRadius,
    this.side = BorderSide.none,
    this.overlayColor,
    this.padding = const EdgeInsets.all(UiConstants.spacing12),
  });
  final BorderRadiusGeometry? borderRadius;
  final Widget child;
  final Color? color;
  final VoidCallback? onPressed;
  final BorderSide side;
  final Color? overlayColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        overlayColor: overlayColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: padding,
        shape: RoundedRectangleBorder(
          side: side,
          borderRadius: borderRadius ?? UiConstants.borderRadiusSmall,
        ),
      ),
      onPressed: onPressed ?? () {},
      child: child,
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    required this.color,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.style,
    super.key,
    this.overlayColor,
    this.side = BorderSide.none,
  });
  final VoidCallback onPressed;
  final Color color;
  final Color? overlayColor;
  final Widget icon;
  final String text;
  final TextStyle? style;
  final BorderSide side;

  @override
  Widget build(BuildContext context) {
    return AppBaseButton(
      color: color,
      overlayColor: overlayColor,
      onPressed: onPressed,
      side: side,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: UiConstants.spacing12),
          Text(text, style: style),
        ],
      ),
    );
  }
}

class FCLPrimaryButton extends StatelessWidget {
  const FCLPrimaryButton({
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBaseButton(
      color: context.theme.primaryColor,
      overlayColor: context.primaryButtonOverlayColor,
      onPressed: onPressed,
      child: Text(text, style: context.primaryButton),
    );
  }
}

class FCLSecondaryButton extends StatelessWidget {
  const FCLSecondaryButton({
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBaseButton(
      side: BorderSide(color: context.theme.primaryColor),
      color: Colors.transparent,
      overlayColor: context.theme.primaryColor,
      onPressed: onPressed,
      child: Text(
        text,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.theme.primaryColor,
        ),
      ),
    );
  }
}
