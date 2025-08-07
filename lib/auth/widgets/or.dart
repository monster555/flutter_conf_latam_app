import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

class Or extends StatelessWidget {
  const Or({super.key});

  @override
  Widget build(BuildContext context) {
    const gap32 = ExcludeSemantics(
      child: SizedBox(height: UiConstants.spacing32),
    );
    return Column(
      children: [
        gap32,
        Semantics(
          label: context.l10n.or,
          child: Text(context.l10n.or, style: context.textTheme.bodyLarge),
        ),
        gap32,
      ],
    );
  }
}
