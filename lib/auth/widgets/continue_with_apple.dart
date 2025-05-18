import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/auth/auth.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

class ContinueWithApple extends StatelessWidget {
  const ContinueWithApple({required this.onPressed, super.key});
  final ValueChanged<SignInType> onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      value: context.l10n.continueWith('Apple'),
      child: SocialButton(
        onPressed: () => onPressed(SignInType.apple),
        icon: Assets.socialIcons.apple.svg(
          colorFilter: switch (context.dark) {
            true => const ColorFilter.mode(Colors.black, BlendMode.modulate),
            false => null,
          },
        ),
        color: context.primaryButtonColor,
        overlayColor: context.primaryButtonOverlayColor,
        text: context.l10n.continueWith('Apple'),
        style: context.primaryButton,
      ),
    );
  }
}
