import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const gap40 = ExcludeSemantics(
      child: SizedBox(height: UiConstants.spacing40),
    );
    return SliverToBoxAdapter(
      child: Column(
        children: [
          gap40,
          Semantics(
            label: l10n.flutterConfLatamLogoDescription,
            child: context.appAssets.logo,
          ),
          const ExcludeSemantics(
            child: SizedBox(height: UiConstants.spacing32),
          ),
          Semantics(
            label: l10n.welcome,
            child: Text(
              l10n.welcome,
              style: context.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          const ExcludeSemantics(child: SizedBox(height: UiConstants.spacing8)),
          Semantics(
            label: l10n.welcomeDescription,
            child: Text(
              l10n.welcomeDescription,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          gap40,
        ],
      ),
    );
  }
}
