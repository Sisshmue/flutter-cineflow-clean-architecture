import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/features/movie/data/data_sources/local_movie_data_source.dart';
import 'package:cineflow/features/movie/data/data_sources/remote_movie_data_source.dart';
import 'package:cineflow/features/movie/domain/entity/movie.dart';
import 'package:cineflow/features/movie/domain/entity/movie_detail.dart';
import 'package:cineflow/features/movie/domain/repository/movie_repository.dart';
import 'package:fpdart/fpdart.dart';

class MovieRepositoryImpl implements MovieRepository {
  final RemoteMovieDataSource remoteMovieDataSource;
  final LocalMovieDataSource localMovieDataSource;
  MovieRepositoryImpl({
    required this.remoteMovieDataSource,
    required this.localMovieDataSource,
  });
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

  @override
  Future<Either<Failure, List<Movie>>> searchMovies({
    required String keyWord,
  }) async {
    try {
      final response = await remoteMovieDataSource.searchMovie(
        keyWord: keyWord,
      );
      return right(response);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail({
    required int movieId,
    required String type,
  }) async {
    try {
      final response = await remoteMovieDataSource.getMovieDetail(
        movieId: movieId,
        type: type,
      );
      return right(response);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getWatchLaterMovies() async {
    try {
      final response = await localMovieDataSource.getWatchLaterMovies();
      return right(response);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveMovieToWatchLater({
    required Movie movie,
  }) async {
    try {
      final response = await localMovieDataSource.saveMovieToWatchLater(
        movie: movie,
      );
      return right(response);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isMovieInWatchLater(int movieId) async {
    try {
      final response = await localMovieDataSource.isMovieInWatchLater(movieId);
      return right(response);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeWatchLaterMovie(int movieId) async {
    try {
      final response = await localMovieDataSource.removeWatchLaterMovie(
        movieId,
      );
      return right(response);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
