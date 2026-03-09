import 'package:cineflow/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../entity/movie.dart';
import '../entity/movie_detail.dart';

abstract interface class MovieRepository {
  Future<Either<Failure, List<Movie>>> getReleaseMovies({required int page});

  Future<Either<Failure, List<Movie>>> searchMovies({
    required String keyWord,
    required int page,
  });

  Future<Either<Failure, MovieDetail>> getMovieDetail({
    required int movieId,
    required String type,
  });

  Future<Either<Failure, List<Movie>>> getWatchLaterMovies();

  Future<Either<Failure, void>> saveMovieToWatchLater({required Movie movie});
  Future<Either<Failure, void>> removeWatchLaterMovie(int movieId);
  Future<Either<Failure, bool>> isMovieInWatchLater(int movieId);
}
