import 'package:conf_auth_data_source/conf_auth_data_source.dart';
import 'package:conf_auth_repository/conf_auth_repository.dart';
import 'package:conf_cache/conf_cache.dart';
import 'package:conf_cloud_functions_data_source/conf_cloud_functions_data_source.dart';
import 'package:connectivity_monitor/connectivity_monitor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_conf_latam/firebase_options.dart';
import 'package:speakers_repository/speakers_repository.dart';
import 'package:sponsors_repository/sponsors_repository.dart';
import 'package:user_repository/user_repository.dart';

typedef AppDependencies =
    ({
      SpeakersRepository speakersRepository,
      SponsorsRepository sponsorsRepository,
      IConfAuthRepository confAuthRepository,
      IUserRepository userRepository,
      IConnectivityMonitorRepository connectivityMonitorRepository,
    });

Future<AppDependencies> initializeApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authDataSource = ConfAuthDataSource();
  final caches = await ConfCacheSystem.initialize();

  final dataSource = ConfCloudFunctionsDataSource();

  final speakersRepository = SpeakersRepository(
    dataSource: dataSource,
    cache: caches.speakers,
  );

  final connectivityMonitorRepository = ConnectivityMonitorRepository();

  final sponsorsRepository = SponsorsRepository(dataSource: dataSource);
  final confAuthRepository = ConfAuthRepository(authDataSource: authDataSource);
  final userRepository = UserRepository(dataSource: dataSource);
  return (
    speakersRepository: speakersRepository,
    sponsorsRepository: sponsorsRepository,
    confAuthRepository: confAuthRepository,
    userRepository: userRepository,
    connectivityMonitorRepository: connectivityMonitorRepository,
  );
}
