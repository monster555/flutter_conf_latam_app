import 'package:conf_cloud_functions_data_source/conf_cloud_functions_data_source.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_conf_latam/firebase_options.dart';
import 'package:speakers_repository/speakers_repository.dart';
import 'package:sponsors_repository/sponsors_repository.dart';

typedef AppDependencies =
    ({
      SpeakersRepository speakersRepository,
      SponsorsRepository sponsorsRepository,
    });

Future<AppDependencies> initializeApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final dataSource = ConfCloudFunctionsDataSource();

  final speakersRepository = SpeakersRepository(dataSource: dataSource);
  final sponsorsRepository = SponsorsRepository(dataSource: dataSource);

  return (
    speakersRepository: speakersRepository,
    sponsorsRepository: sponsorsRepository,
  );
}
