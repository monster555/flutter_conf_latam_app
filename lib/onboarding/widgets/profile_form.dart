import 'dart:async';

import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart' hide Form;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/common/common.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/onboarding/cubits/update_information/update_information_cubit.dart';
import 'package:flutter_conf_latam/onboarding/onboarding_page.dart';
import 'package:flutter_conf_latam/router/fcl_routes.dart';
import 'package:flutter_conf_latam/utils/show_loader.dart';
import 'package:go_router/go_router.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    const gap16 = ExcludeSemantics(
      child: SizedBox(height: UiConstants.spacing16),
    );
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(children: [_Names(), gap16, _LastName(), gap16]),
          ),
          _Continue(),
        ],
      ),
    );
  }
}

class _LastName extends StatelessWidget {
  const _LastName();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ValueCubit<OnboardingData>>();
    final l10n = context.l10n;

    return Semantics(
      label: l10n.onboardingLastNameLabel,
      textField: true,
      child: FCLTextField(
        label: l10n.onboardingLastNameLabel,
        onChanged: (value) {
          final state = cubit.state;
          final data = (name: state.name, lastName: value, photo: state.photo);
          cubit.update(data);
        },
      ),
    );
  }
}

class _Names extends StatelessWidget {
  const _Names();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ValueCubit<OnboardingData>>();
    final l10n = context.l10n;
    return Semantics(
      label: l10n.onboardingNamesLabel,
      textField: true,
      child: FCLTextField(
        label: l10n.onboardingNamesLabel,
        onChanged: (value) {
          final state = cubit.state;
          final data = (
            name: value,
            lastName: state.lastName,
            photo: state.photo,
          );
          cubit.update(data);
        },
      ),
    );
  }
}

class _Continue extends StatelessWidget {
  const _Continue();

  Future<void> _continue(BuildContext context) async {
    final data = context.read<ValueCubit<OnboardingData>>().state;
    return showLoader(
      context,
      routeParam: FCLRoutes.onboarding.path.replaceAll('/', ''),
      context.read<UpdateInformationCubit>().update(
        firstName: data._name,
        lastName: data._lastName,
        photo: data.photo,
      ),
    );
  }

  void _successListener(BuildContext context, UpdateInformationState state) {
    final user = switch (state) {
      UpdatedInformation(:final user) => user,
      _ => null,
    };
    if (user == null) return;
    context
      ..read<SessionCubit>().updateUser(user)
      ..pushNamed<bool>(FCLRoutes.fclCard.name);
  }

  Future<void> _errorListener(
    BuildContext context,
    UpdateInformationState _,
  ) async {
    final retry = await context.pushNamed<bool?>(
      FCLRoutes.onboardingError.name,
      extra: {'type': ErrorDialogType.generic.name},
    );
    if (retry != null && retry && context.mounted) {
      return _continue(context);
    }
  }

  bool _successListenWhen(
    UpdateInformationState previous,
    UpdateInformationState current,
  ) {
    return switch ((previous, current)) {
      (UpdatingInformation(), UpdatedInformation()) => true,
      (_, _) => false,
    };
  }

  bool _errorListenWhen(
    UpdateInformationState previous,
    UpdateInformationState current,
  ) {
    return switch ((previous, current)) {
      (UpdatingInformation(), UpdatingInformationError()) => true,
      (_, _) => false,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateInformationCubit, UpdateInformationState>(
          listener: _successListener,
          listenWhen: _successListenWhen,
        ),
        BlocListener<UpdateInformationCubit, UpdateInformationState>(
          listener: _errorListener,
          listenWhen: _errorListenWhen,
        ),
      ],
      child: BlocBuilder<ValueCubit<OnboardingData>, OnboardingData>(
        builder: (context, data) {
          return Semantics(
            button: true,
            enabled: data.buttonEnable,
            label: l10n.onboardingContinue,
            child: IgnorePointer(
              ignoring: !data.buttonEnable,
              child: AppBaseButton(
                color: switch (data.buttonEnable) {
                  true => context.theme.primaryColor,
                  false => null,
                },
                onPressed: () => _continue(context),
                child: Text(
                  l10n.onboardingContinue,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: switch (data.buttonEnable) {
                      true => context.continueButtonColorEnable,
                      false => context.continueButtonColorDisable,
                    },
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

extension on OnboardingData {
  String get _name => name ?? '';
  String get _lastName => lastName ?? '';

  bool get buttonEnable {
    final nameComplete = _name.isNotEmpty && _name.length > 3;
    final lastNameComplete = _lastName.isNotEmpty && _lastName.length > 3;
    return nameComplete && lastNameComplete;
  }
}
