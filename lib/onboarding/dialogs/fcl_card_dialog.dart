import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/common/common.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/onboarding/widgets/widgets.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:go_router/go_router.dart';

enum BadgeTheme { blue, yellow }

extension BadgeThemeX on BadgeTheme {
  Color get primary => switch (this) {
    BadgeTheme.blue => const Color(0xFF016EE8),
    BadgeTheme.yellow => const Color(0xFFFAB92D),
  };

  SvgGenImage get quitoLogo => switch (this) {
    BadgeTheme.blue => Assets.images.quitoWhite,
    BadgeTheme.yellow => Assets.images.quitoBlue,
  };
}

class FCLCardDialog extends StatelessWidget {
  const FCLCardDialog._();

  static Page<T?> builder<T>(BuildContext _, GoRouterState _) {
    return DialogPage(
      barrierDismissible: false,
      builder: (_) => const FCLCardDialog._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const gap16 = ExcludeSemantics(
      child: SizedBox(height: UiConstants.spacing16),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ValueCubit(BadgeTheme.blue)),
        RepositoryProvider(create: (_) => GlobalKey()),
      ],
      child: const FCLBaseDialog(
        margin: EdgeInsets.symmetric(horizontal: UiConstants.spacing20),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Title(),
            gap16,
            FCLUserCard(),
            gap16,
            BadgeThemeSelector(),
            ExcludeSemantics(child: SizedBox(height: UiConstants.spacing24)),
            SharedButtons(),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Semantics(
      header: true,
      label: l10n.shareDialogTitle,
      child: Text(
        l10n.shareDialogTitle,
        textAlign: TextAlign.center,
        style: context.textTheme.titleMedium,
      ),
    );
  }
}
