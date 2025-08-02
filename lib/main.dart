import 'package:conf_auth_repository/conf_auth_repository.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/app/app.dart';
import 'package:flutter_conf_latam/app/localizations_manager.dart';
import 'package:flutter_conf_latam/app_initialization.dart';
import 'package:flutter_conf_latam/common/cubits/session/session_cubit.dart';
import 'package:flutter_conf_latam/l10n/generated/app_localizations.dart';
import 'package:flutter_conf_latam/router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:speakers_repository/speakers_repository.dart';
import 'package:sponsors_repository/sponsors_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocalizationsManager.initialize();

  final dependencies = await initializeApp();

  runApp(MainApp(dependencies: dependencies));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.dependencies, super.key});

  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SpeakersRepository>.value(
          value: dependencies.speakersRepository,
        ),
        RepositoryProvider<SponsorsRepository>.value(
          value: dependencies.sponsorsRepository,
        ),
        RepositoryProvider<IConfAuthRepository>.value(
          value: dependencies.confAuthRepository,
        ),
        BlocProvider(
          create: (context) {
            return SessionCubit(
              const CheckingSession(),
              authRepository: context.read(),
            )..checkSession();
          },
        ),
        RepositoryProvider<GoRouter>(
          create:
              (context) => GoRouter(
                initialLocation: FCLRoutes.auth.path,
                routes: FCLRouter.routes,
                navigatorKey: GlobalKey<NavigatorState>(),
                debugLogDiagnostics: kDebugMode,
                redirect: FCLRouter.redirect,
                refreshListenable: GoRouterRefreshStream(
                  context.read<SessionCubit>().stream,
                ),
              ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'FlutterConf LATAM',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: context.read<GoRouter>(),
            builder: (_, child) => App(child: child!),
          );
        },
      ),
    );
  }
}
