import 'package:flutter/material.dart';

class FCLAnimatedVisible extends StatelessWidget {
  const FCLAnimatedVisible({
    super.key,
    this.visible = true,
    this.child,
    this.replacement,
  });
  final bool visible;
  final Widget? child;
  final Widget? replacement;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: visible ? child : replacement ?? const SizedBox.shrink(),
    );
  }
}
