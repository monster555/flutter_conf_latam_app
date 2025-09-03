import 'package:agenda_repository/agenda_repository.dart';
import 'package:conf_auth_data_source/conf_auth_data_source.dart';
import 'package:conf_auth_repository/conf_auth_repository.dart';
import 'package:conf_cache/conf_cache.dart';
import 'package:conf_cloud_functions_data_source/conf_cloud_functions_data_source.dart';
import 'package:connectivity_monitor/connectivity_monitor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conf_latam/firebase_options.dart';
import 'package:speakers_repository/speakers_repository.dart';
import 'package:sponsors_repository/sponsors_repository.dart';
import 'package:user_repository/user_repository.dart';

typedef AppDependencies =
    ({
      SpeakersRepository speakersRepository,
      AgendaRepository agendaRepository,
      SponsorsRepository sponsorsRepository,
      IConfAuthRepository confAuthRepository,
      IUserRepository userRepository,
      IConnectivityMonitorRepository connectivityMonitorRepository,
    });

Future<AppDependencies> initializeApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authDataSource = ConfAuthDataSource();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  final caches = await ConfCacheSystem.initialize();

  final dataSource = ConfCloudFunctionsDataSource();

  final speakersRepository = SpeakersRepository(
    dataSource: dataSource,
    cache: caches.speakers,
  );

  final agendaRepository = AgendaRepository(
    dataSource: dataSource,
    cache: caches.agenda,
  );

  final sponsorsRepository = SponsorsRepository(
    dataSource: dataSource,
    cache: caches.sponsors,
  );

  final connectivityMonitorRepository = ConnectivityMonitorRepository();

  final confAuthRepository = ConfAuthRepository(authDataSource: authDataSource);
  final userRepository = UserRepository(dataSource: dataSource);
  return (
    speakersRepository: speakersRepository,
    agendaRepository: agendaRepository,
    sponsorsRepository: sponsorsRepository,
    confAuthRepository: confAuthRepository,
    userRepository: userRepository,
    connectivityMonitorRepository: connectivityMonitorRepository,
  );
}
