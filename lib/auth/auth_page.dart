import 'dart:io';

import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/auth/auth.dart';
import 'package:flutter_conf_latam/common/common.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:flutter_conf_latam/utils/show_loader.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage._({super.key});

  static Widget builder(BuildContext _, GoRouterState state) {
    return AuthPage._(key: state.pageKey);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ValueCubit<TermsAcceptanceStatus?>(null)),
        BlocProvider(
          create: (context) {
            return SignInCubit(
              const SingInInitialState(),
              authRepository: context.read(),
              monitorRepository: context.read(),
            );
          },
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            AppBar(
              backgroundColor: context.scaffoldBackgroundColor,
              elevation: 0,
              forceMaterialTransparency: true,
              systemOverlayStyle: switch (context.dark) {
                true => SystemUiOverlayStyle.light,
                false => SystemUiOverlayStyle.dark,
              },
            ),
            const SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: UiConstants.spacing32,
                ),
                child: CustomScrollView(
                  slivers: [AuthHeader(), AuthButtons(), TermsAndConditions()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthButtons extends StatelessWidget {
  const AuthButtons({super.key});

  Future<void> _listener(BuildContext context, SignInState state) async {
    final retry = await context.pushNamed<bool?>(
      FCLRoutes.authError.name,
      extra: {'type': state.type?.name},
    );
    if (retry != null && retry && context.mounted && state.signInType != null) {
      return _startSignInFlow(state.signInType!, context);
    }
  }

  bool _listenWhen(SignInState previous, SignInState current) {
    return switch ((previous, current)) {
      (SignInLoadingState(), SignInErrorState()) => true,
      (_, _) => false,
    };
  }

  Future<void> _startSignInFlow(SignInType type, BuildContext context) async {
    final state = context.read<ValueCubit<TermsAcceptanceStatus?>>().state;
    final accepted = state == TermsAcceptanceStatus.accepted;
    if (!accepted) {
      return _showTermAndConditionsError(context);
    }
    await showLoader(
      context,
      routeParam: FCLRoutes.auth.path.replaceAll('/', ''),
      _performSignIn(type, context),
    );
  }

  Future<void> _performSignIn(SignInType type, BuildContext context) async {
    final result = await context.read<SignInCubit>().signIn(type);
    if (!context.mounted || result is Failure) return;
    return context.read<SessionCubit>().checkSession();
  }

  void _showTermAndConditionsError(BuildContext context) {
    return FCLSnackbar.show(
      context,
      type: FCLSnackbarType.warning,
      title: context.l10n.termsAndConditionsErrorTitle,
      description: context.l10n.termsAndConditionsErrorDescription,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocListener<SignInCubit, SignInState>(
        listener: _listener,
        listenWhen: _listenWhen,
        child: Column(
          children: [
            if (Platform.isIOS) ...[
              ContinueWithApple(
                onPressed: (type) => _startSignInFlow(type, context),
              ),
              const ExcludeSemantics(
                child: SizedBox(height: UiConstants.spacing12),
              ),
            ],
            ContinueWithGoogle(
              onPressed: (type) => _startSignInFlow(type, context),
            ),
            const Or(),
            ContinueAsGuest(
              onPressed: (type) => _startSignInFlow(type, context),
            ),
          ],
        ),
      ),
    );
  }
}
