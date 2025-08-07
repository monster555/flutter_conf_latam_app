import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/common/common.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:flutter_conf_latam/utils/utils.dart';
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
    final l10n = context.l10n;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ValueCubit(BadgeTheme.blue)),
        RepositoryProvider(create: (_) => GlobalKey()),
      ],
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: UiConstants.spacing20,
          ),
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.scaffoldBackgroundColor,
                borderRadius: UiConstants.borderRadiusLarge,
              ),
              child: Padding(
                padding: const EdgeInsets.all(UiConstants.spacing24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Semantics(
                      header: true,
                      label: l10n.shareDialogTitle,
                      child: Text(
                        l10n.shareDialogTitle,
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                    gap16,
                    const _FCLCard(),
                    gap16,
                    const _BadgeThemeSelector(),
                    const ExcludeSemantics(
                      child: SizedBox(height: UiConstants.spacing24),
                    ),
                    const _Buttons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BadgeThemeSelector extends StatelessWidget {
  const _BadgeThemeSelector();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        _Badge(badgeTheme: BadgeTheme.blue),
        _Badge(badgeTheme: BadgeTheme.yellow),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.badgeTheme});

  final BadgeTheme badgeTheme;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GestureDetector(
      onTap: () => context.read<ValueCubit<BadgeTheme>>().update(badgeTheme),
      child: SizedBox.square(
        dimension: 24,
        child: BlocBuilder<ValueCubit<BadgeTheme>, BadgeTheme>(
          builder: (context, state) {
            final selected = badgeTheme == state;
            final label = switch (badgeTheme) {
              BadgeTheme.blue => l10n.shareBadgeThemeBlue,
              BadgeTheme.yellow => l10n.shareBadgeThemeYellow,
            };
            return Semantics(
              button: true,
              selected: selected,
              label: label,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: badgeTheme.primary,
                  shape: BoxShape.circle,
                  border: switch (selected) {
                    true => Border.all(
                      width: 2.5,
                      color: const Color(0XFF101828),
                    ),
                    false => null,
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FCLCard extends StatelessWidget {
  const _FCLCard();

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

class _Buttons extends StatelessWidget {
  const _Buttons();

  Future<void> _startCaptureAndShared(BuildContext context) async {
    final result = await showLoader(
      context,
      _performCaptureAndShared(context),
      route: FCLRoutes.sharingFclCard.name,
    );
    if (result && context.mounted) context.goNamed(FCLRoutes.home.name);
  }

  Future<bool> _performCaptureAndShared(BuildContext context) async {
    await WidgetsBinding.instance.endOfFrame;
    if (!context.mounted) return false;
    final globalKey = context.read<GlobalKey>();
    final captureUtil = context.read<CaptureUtil>();
    final user = context.read<SessionCubit>().state.user;
    final file = await captureUtil.captureWidgetToFile(
      globalKey,
      filename: user.safeShareFilename(),
    );
    if (file == null || !context.mounted) return false;
    final l10n = context.l10n;
    final text =
        '${l10n.badgeImPartOf} ${l10n.badgeConference} ${l10n.badgeYear}';
    final subject = '${l10n.badgeConference} ${l10n.badgeYear}';
    final shareUtil = context.read<ShareUtil>();
    return shareUtil.shareFile(file, text: text, subject: subject);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Semantics(
            label: l10n.shareLater,
            header: true,
            child: FCLSecondaryButton(
              text: l10n.shareLater,
              onPressed: () => context.goNamed(FCLRoutes.home.name),
            ),
          ),
        ),
        Expanded(
          child: Semantics(
            label: l10n.shareAction,
            header: true,
            child: FCLPrimaryButton(
              text: l10n.shareAction,
              onPressed: () => _startCaptureAndShared(context),
            ),
          ),
        ),
      ],
    );
  }
}
