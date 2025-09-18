import 'package:flutter/material.dart' hide BadgeTheme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/common/cubits/cubits.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/onboarding/dialogs/dialogs.dart';

class BadgeThemeSelector extends StatelessWidget {
  const BadgeThemeSelector({super.key});

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
