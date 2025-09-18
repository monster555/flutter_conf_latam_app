import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/auth/auth.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

class ContinueAsGuest extends StatelessWidget {
  const ContinueAsGuest({required this.onPressed, super.key});
  final ValueChanged<SignInType> onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.continueAsGuests,
      child: SocialButton(
        onPressed: () => onPressed(SignInType.guest),
        icon: Assets.icons.face.svg(
          colorFilter: switch (context.dark) {
            true => const ColorFilter.mode(Colors.white, BlendMode.srcATop),
            false => null,
          },
        ),
        color: Colors.transparent,
        overlayColor: const Color(0XFFD0D5DD),
        text: context.l10n.continueAsGuests,
        side: const BorderSide(color: Color(0XFFD0D5DD)),
        style: context.secondaryButton,
      ),
    );
  }
}
