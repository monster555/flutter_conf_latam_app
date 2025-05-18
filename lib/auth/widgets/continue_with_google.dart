import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/auth/auth.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

class ContinueWithGoogle extends StatelessWidget {
  const ContinueWithGoogle({required this.onPressed, super.key});
  final ValueChanged<SignInType> onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      value: context.l10n.continueWith('Google'),
      child: SocialButton(
        onPressed: () => onPressed(SignInType.google),
        icon: Assets.socialIcons.google.svg(),
        color: Colors.transparent,
        overlayColor: const Color(0XFFD0D5DD),
        text: context.l10n.continueWith('Google'),
        side: const BorderSide(color: Color(0XFFD0D5DD)),
        style: context.secondaryButton,
      ),
    );
  }
}
