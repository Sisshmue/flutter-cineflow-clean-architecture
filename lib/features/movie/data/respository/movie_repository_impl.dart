import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/features/movie/data/data_sources/remote_movie_data_source.dart';
import 'package:cineflow/features/movie/domain/entity/movie.dart';
import 'package:cineflow/features/movie/domain/repository/movie_repository.dart';
import 'package:fpdart/src/either.dart';

class MovieRepositoryImpl implements MovieRepository {
  final RemoteMovieDataSource remoteMovieDataSource;
  MovieRepositoryImpl({required this.remoteMovieDataSource});
  @override
  Future<Either<Failure, List<Movie>>> getReleaseMovies({
    required String apiKey,
  }) async {
    try {
      final response = await remoteMovieDataSource.getMovie(apiKey: apiKey);
      return right(response);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
