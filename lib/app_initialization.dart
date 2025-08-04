import 'package:agenda_repository/agenda_repository.dart';
import 'package:conf_cache/conf_cache.dart';
import 'package:conf_cloud_functions_data_source/conf_cloud_functions_data_source.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_conf_latam/firebase_options.dart';
import 'package:speakers_repository/speakers_repository.dart';
import 'package:sponsors_repository/sponsors_repository.dart';

typedef AppDependencies =
    ({
      SpeakersRepository speakersRepository,
      AgendaRepository agendaRepository,
      SponsorsRepository sponsorsRepository,
    });

Future<AppDependencies> initializeApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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

  final sponsorsRepository = SponsorsRepository(dataSource: dataSource);

  return (
    speakersRepository: speakersRepository,
    agendaRepository: agendaRepository,
    sponsorsRepository: sponsorsRepository,
  );
}
