import 'dart:io';

import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart' hide Form;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/common/cubits/cubits.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/onboarding/cubits/cubits.dart';
import 'package:flutter_conf_latam/onboarding/widgets/widgets.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:go_router/go_router.dart';

typedef OnboardingData = ({String? name, String? lastName, File? photo});

class OnboardingPage extends StatelessWidget {
  const OnboardingPage._();

  static Widget builder(BuildContext _, GoRouterState __) {
    return const OnboardingPage._();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            const data = (name: null, lastName: null, photo: null);
            return ValueCubit<OnboardingData>(data);
          },
        ),
        BlocProvider(
          create: (_) {
            return UpdateInformationCubit(
              const UpdateInformationInitialState(),
              userRepository: context.read(),
              authRepository: context.read(),
            );
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: switch (context.dark) {
            true => SystemUiOverlayStyle.light,
            false => SystemUiOverlayStyle.dark,
          },
          forceMaterialTransparency: true,
          actions: const [_Skip()],
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: UiConstants.spacing32),
            child: CustomScrollView(
              slivers: [_Title(), ProfilePhoto(), ProfileForm()],
            ),
          ),
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
    return SliverPadding(
      padding: const EdgeInsets.only(top: UiConstants.spacing20),
      sliver: SliverToBoxAdapter(
        child: Semantics(
          label: l10n.onboardingTitle,
          header: true,
          child: Text(
            l10n.onboardingTitle,
            style: context.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _Skip extends StatelessWidget {
  const _Skip();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Semantics(
      label: l10n.onboardingSkip,
      button: true,
      child: TextButton(
        onPressed: () => context.goNamed(FCLRoutes.home.name),
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
        ),
        child: Text(
          l10n.onboardingSkip,
          style: context.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
