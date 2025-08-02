import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/auth/auth_page.dart';
import 'package:flutter_conf_latam/common/common.dart';
import 'package:flutter_conf_latam/home/home_page.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:go_router/go_router.dart';

class FCLRouter {
  const FCLRouter._();

  static List<RouteBase> get routes {
    return [
      GoRoute(
        path: FCLRoutes.splash.path,
        name: FCLRoutes.splash.name,
        builder: (_, __) => const Scaffold(),
      ),
      GoRoute(
        path: FCLRoutes.auth.path,
        name: FCLRoutes.auth.name,
        builder: AuthPage.builder,
      ),
      GoRoute(
        path: FCLRoutes.onboarding.path,
        name: FCLRoutes.onboarding.name,
        builder: HomePage.builder,
      ),
      GoRoute(
        path: FCLRoutes.home.path,
        name: FCLRoutes.home.name,
        builder: HomePage.builder,
      ),
      GoRoute(
        path: FCLRoutes.loading.path,
        name: FCLRoutes.loading.name,
        pageBuilder: LoadingDialog.builder,
      ),
    ];
  }

  static String? redirect(BuildContext context, GoRouterState state) {
    final authState = context.read<SessionCubit>().state;
    final fullPath = state.fullPath;
    if (fullPath.loading) return null;
    return switch (authState) {
      SessionIncompleteProfile() when fullPath.splash => FCLRoutes.home.path,
      SessionIncompleteProfile() when fullPath.auth =>
        FCLRoutes.onboarding.path,
      SessionAuthenticated() when fullPath.splash || fullPath.auth =>
        FCLRoutes.home.path,
      SessionUnauthenticated() when !fullPath.auth => FCLRoutes.auth.path,
      _ => null,
    };
  }
}

extension on String? {
  bool get loading => this?.contains(FCLRoutes.loading.path) ?? false;
  bool get splash => this?.contains(FCLRoutes.splash.path) ?? false;
  bool get auth => this?.contains(FCLRoutes.auth.path) ?? false;
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(this.stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }
  final Stream<SessionState> stream;
  late final StreamSubscription<SessionState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
