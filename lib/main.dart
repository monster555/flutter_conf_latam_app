import 'package:agenda_repository/agenda_repository.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conf_latam/app/app.dart';
import 'package:flutter_conf_latam/app/localizations_manager.dart';
import 'package:flutter_conf_latam/app_initialization.dart';
import 'package:flutter_conf_latam/l10n/generated/app_localizations.dart';
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
        RepositoryProvider<AgendaRepository>.value(
          value: dependencies.agendaRepository,
        ),
        RepositoryProvider<SpeakersRepository>.value(
          value: dependencies.speakersRepository,
        ),
        RepositoryProvider<SponsorsRepository>.value(
          value: dependencies.sponsorsRepository,
        ),
      ],
      child: MaterialApp(
        title: 'FlutterConf LATAM',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const App(),
      ),
    );
  }
}
