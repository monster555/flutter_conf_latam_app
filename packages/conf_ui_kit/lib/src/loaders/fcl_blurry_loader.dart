import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';

class FCLBlurryLoader extends StatelessWidget {
  const FCLBlurryLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 5),
      duration: const Duration(milliseconds: 750),
      builder: (_, value, child) {
        return FrostedGlass(
          sigma: value,
          color: Colors.transparent,
          child: FCLAnimatedVisible(visible: value >= 2.5, child: child),
        );
      },
      child: const Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
