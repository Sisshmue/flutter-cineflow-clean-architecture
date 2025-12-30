import 'package:cineflow/core/secrets/secrets_data.dart';
import 'package:cineflow/features/movie/data/data_sources/remote_movie_data_source.dart';
import 'package:cineflow/features/movie/data/respository/movie_repository_impl.dart';
import 'package:cineflow/features/movie/domain/repository/movie_repository.dart';
import 'package:cineflow/features/movie/domain/usecases/get_released_movies.dart';
import 'package:cineflow/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void initDependencies() {
  serviceLocator.registerLazySingleton(() => SecretsData.apiKey);

  serviceLocator.registerFactory<RemoteMovieDataSource>(
    () => RemoteMovieDataSourceImpl(),
  );

  serviceLocator.registerFactory<MovieRepository>(
    () => MovieRepositoryImpl(remoteMovieDataSource: serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => GetReleasedMovies(movieRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () =>
        MovieBloc(getReleaseMovies: serviceLocator(), apiKey: serviceLocator()),
  );
}
