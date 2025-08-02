import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
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
            );
          },
        ),
      ],
      child: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: UiConstants.spacing32),
            child: CustomScrollView(
              slivers: [AuthHeader(), AuthButtons(), TermsAndConditions()],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthButtons extends StatelessWidget {
  const AuthButtons({super.key});

  Future<void> _signIn(SignInType type, BuildContext context) async {
    final state = context.read<ValueCubit<TermsAcceptanceStatus?>>().state;
    final accepted = state == TermsAcceptanceStatus.accepted;
    if (!accepted) {
      return _showTermAndConditionsError(context);
    }
    await showLoader(
      context,
      FCLRoutes.auth.path.replaceAll('/', ''),
      context.read<SignInCubit>().signIn(type),
    );
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
      child: Column(
        children: [
          ContinueWithApple(onPressed: (type) => _signIn(type, context)),
          const ExcludeSemantics(
            child: SizedBox(height: UiConstants.spacing12),
          ),
          ContinueWithGoogle(onPressed: (type) => _signIn(type, context)),
          const Or(),
          ContinueAsGuest(onPressed: (type) => _signIn(type, context)),
        ],
      ),
    );
  }
}
