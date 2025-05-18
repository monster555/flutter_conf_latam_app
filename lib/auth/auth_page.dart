import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/auth/auth.dart';
import 'package:flutter_conf_latam/common/common.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ValueCubit(TermsAcceptanceStatus.notAccepted),
        ),
        BlocProvider(
          create: (_) {
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
    final state = context.read<ValueCubit<TermsAcceptanceStatus>>().state;
    final accepted = state == TermsAcceptanceStatus.accepted;
    if (!accepted) {
      return _showTermAndConditionsError(context);
    }
    await context.read<SignInCubit>().signIn(type);
  }

  void _showTermAndConditionsError(BuildContext context) {
    FCLSnackbar.show(
      context,
      type: FCLSnackbarType.warning,
      title: 'Un último paso',
      description: 'Acepta nuestros términos y políticas.',
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
