import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart' hide BadgeTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/common/common.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/onboarding/dialogs/dialogs.dart';

class FCLUserCard extends StatelessWidget {
  const FCLUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValueCubit<BadgeTheme>, BadgeTheme>(
      builder: (_, theme) {
        return ClipRRect(
          borderRadius: UiConstants.borderRadiusMedium,
          child: RepaintBoundary(
            key: context.read<GlobalKey>(),
            child: DecoratedBox(
              decoration: BoxDecoration(color: theme.primary),
              child: const Stack(
                children: [_QuitoLogo(), _DashEcuador(), _UserInfo()],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DashEcuador extends StatelessWidget {
  const _DashEcuador();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Semantics(
        image: true,
        label: context.l10n.dashEcuadorLabel,
        child: Assets.brand.dashEcuador.image(width: 92),
      ),
    );
  }
}

class _QuitoLogo extends StatelessWidget {
  const _QuitoLogo();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -12,
      left: -12,
      right: -12,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return BlocBuilder<ValueCubit<BadgeTheme>, BadgeTheme>(
            builder: (_, theme) {
              return Semantics(
                image: true,
                label: context.l10n.quitoLogoLabel,
                child: theme.quitoLogo.svg(width: constraints.maxWidth),
              );
            },
          );
        },
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo();

  @override
  Widget build(BuildContext context) {
    final badgeTheme = context.watch<ValueCubit<BadgeTheme>>().state;

    final textColor = switch (badgeTheme) {
      BadgeTheme.blue => context.continueButtonColorEnable,
      BadgeTheme.yellow => context.flutterNavy,
    };
    final baseTextStyle = context.textTheme.titleMedium?.copyWith(
      color: textColor,
      fontSize: 12,
      height: 1,
      letterSpacing: 0.48,
    );

    final recoletaAltBlack24Center = TextStyle(
      color: textColor,
      fontFamily: FontFamily.recoleta,
      package: Assets.package,
      fontWeight: FontWeight.w900,
      fontSize: 24,
      height: 1,
      letterSpacing: 0,
    );
    const gap16 = ExcludeSemantics(
      child: SizedBox(height: UiConstants.spacing16),
    );

    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(UiConstants.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: UserProfileAvatar()),
          gap16,
          Semantics(
            label: l10n.badgeImPartOf,
            child: Text(
              l10n.badgeImPartOf,
              style: baseTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          gap16,
          Semantics(
            header: true,
            label: '${l10n.badgeConference}\n${l10n.badgeYear}',
            child: Text(
              '${l10n.badgeConference}\n${l10n.badgeYear}',
              textAlign: TextAlign.center,
              style: recoletaAltBlack24Center,
            ),
          ),
          gap16,
          Semantics(
            label: l10n.badgeLocation,
            child: Text(
              l10n.badgeLocation,
              style: baseTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const ExcludeSemantics(
            child: SizedBox(height: UiConstants.spacing20),
          ),
          Semantics(
            label: l10n.hashtagBeFCL25,
            child: Text(
              l10n.hashtagBeFCL25,
              style: baseTextStyle?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 0.56,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
