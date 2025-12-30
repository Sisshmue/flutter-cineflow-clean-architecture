import 'package:cineflow/core/secrets/secrets_data.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  serviceLocator.registerLazySingleton(() => SecretsData.apiKey);
}
