import 'package:cineflow/core/secrets/secrets_data.dart';
import 'package:cineflow/features/auth/data/data_source/user_remote_data_source.dart';
import 'package:cineflow/features/auth/data/respository_impl/auth_repository_impl.dart';
import 'package:cineflow/features/auth/domain/repository/auth_repository.dart';
import 'package:cineflow/features/auth/domain/usecase/user_log_in.dart';
import 'package:cineflow/features/auth/domain/usecase/user_sign_up.dart';
import 'package:cineflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cineflow/features/movie/data/data_sources/remote_movie_data_source.dart';
import 'package:cineflow/features/movie/data/respository/movie_repository_impl.dart';
import 'package:cineflow/features/movie/domain/repository/movie_repository.dart';
import 'package:cineflow/features/movie/domain/usecases/get_movie_detail.dart';
import 'package:cineflow/features/movie/domain/usecases/get_released_movies.dart';
import 'package:cineflow/features/movie/domain/usecases/search_movies.dart';
import 'package:cineflow/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:cineflow/features/movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:cineflow/features/recommendation/data/data_sources/remote_data_recommendation_source.dart';
import 'package:cineflow/features/recommendation/data/repositroy/recommendation_impl.dart';
import 'package:cineflow/features/recommendation/domain/repository/recommendation_repository.dart';
import 'package:cineflow/features/recommendation/domain/usecase/get_recommendations.dart';
import 'package:cineflow/features/recommendation/presentation/bloc/recommendation_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: SecretsData.supabaseUrl,
    anonKey: SecretsData.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(() => SecretsData.apiKey);

  //Movie
  serviceLocator
    ..registerFactory<RemoteMovieDataSource>(() => RemoteMovieDataSourceImpl())
    ..registerFactory<MovieRepository>(
      () => MovieRepositoryImpl(remoteMovieDataSource: serviceLocator()),
    )
    ..registerFactory(
      () => GetReleasedMovies(movieRepository: serviceLocator()),
    )
    ..registerFactory(() => SearchMovies(serviceLocator()))
    ..registerLazySingleton(
      () => MovieBloc(
        getReleaseMovies: serviceLocator(),
        apiKey: serviceLocator(),
        searchMovies: serviceLocator(),
      ),
    );

  //Auth
  serviceLocator
    ..registerFactory<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(userRemoteDataSource: serviceLocator()),
    )
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory(() => UserLogIn(authRepository: serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(userSignup: serviceLocator(), userLogin: serviceLocator()),
    );

  //movie detail
  serviceLocator
    ..registerFactory<GetMovieDetail>(
      () => GetMovieDetail(movieRepository: serviceLocator()),
    )
    ..registerLazySingleton(
      () => (MovieDetailBloc(getMovieDetail: serviceLocator())),
    );

  //recommendation
  serviceLocator
    ..registerFactory<RemoteDataRecommendationSource>(
      () => RemoteDataRecommendationSourceImpl(),
    )
    ..registerFactory<RecommendationRepository>(
      () =>
          RecommendationImpl(remoteDataRecommendationSource: serviceLocator()),
    )
    ..registerFactory(
      () => GetRecommendations(recommendationRepository: serviceLocator()),
    )
    ..registerLazySingleton(
      () => (RecommendationBloc(getRecommendations: serviceLocator())),
    );
}
