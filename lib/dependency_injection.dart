import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/app_initialization.dart';
import 'package:flutter_conf_latam/common/cubits/cubits.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:flutter_conf_latam/utils/utils.dart';
import 'package:go_router/go_router.dart';

class DependencyInjection extends StatelessWidget {
  const DependencyInjection({
    required this.appBuilder,
    required this.dependencies,
    super.key,
  });
  final MaterialApp Function(BuildContext) appBuilder;
  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: dependencies.speakersRepository),
        RepositoryProvider.value(value: dependencies.sponsorsRepository),
        RepositoryProvider.value(value: dependencies.confAuthRepository),
        RepositoryProvider.value(value: dependencies.userRepository),
        RepositoryProvider.value(
          value: dependencies.connectivityMonitorRepository,
        ),
        RepositoryProvider(create: (_) => const CaptureUtil()),
        RepositoryProvider(create: (_) => const ShareUtil()),
        BlocProvider(
          create: (context) {
            return SessionCubit(
              const CheckingSession(),
              authRepository: context.read(),
              userRepository: context.read(),
            )..checkSession();
          },
        ),
        RepositoryProvider<GoRouter>(
          create: (context) {
            return GoRouter(
              initialLocation: FCLRoutes.splash.path,
              routes: FCLRouter.routes,
              navigatorKey: GlobalKey<NavigatorState>(),
              debugLogDiagnostics: kDebugMode,
              redirect: FCLRouter.redirect,
              refreshListenable: GoRouterRefreshStream(
                context.read<SessionCubit>().stream,
              ),
            );
          },
        ),
      ],
      child: Builder(builder: appBuilder),
    );
  }
}
