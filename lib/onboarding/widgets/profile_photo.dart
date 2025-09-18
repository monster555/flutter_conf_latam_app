import 'dart:io';

import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/common/cubits/value_cubit.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/onboarding/onboarding_page.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(vertical: UiConstants.spacing24),
      sliver: SliverToBoxAdapter(
        child: Column(children: [_Preview(), _Select()]),
      ),
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.l10n.onboardingPhotoPreview,
      image: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: SizedBox.square(
          dimension: 120,
          child: BlocBuilder<ValueCubit<OnboardingData>, OnboardingData>(
            builder: (context, data) {
              return DecoratedBox(
                decoration: const BoxDecoration(color: Color(0XFFD0D5DD)),
                child: switch (data.photo) {
                  final File file => Image.file(file, fit: BoxFit.cover),
                  null => Center(child: Assets.icons.person.svg()),
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Select extends StatelessWidget {
  const _Select();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(top: UiConstants.spacing16),
      child: BlocBuilder<ValueCubit<OnboardingData>, OnboardingData>(
        builder: (_, data) {
          return FCLSelectImage(
            onFile: (value) {
              final newData = (
                name: data.name,
                lastName: data.lastName,
                photo: value,
              );
              context.read<ValueCubit<OnboardingData>>().update(newData);
            },
            child: Semantics(
              button: true,
              label: l10n.onboardingUpdatePhoto,
              enabled: true,
              child: AbsorbPointer(
                child: AppBaseButton(
                  color: switch (data.photo) {
                    null => context.theme.primaryColor,
                    File() => context.updateSelectedPhotoColor,
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 18,
                        color: context.continueButtonColorEnable,
                      ),
                      const SizedBox(width: UiConstants.spacing8),
                      Text(
                        l10n.onboardingUpdatePhoto,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.continueButtonColorEnable,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
