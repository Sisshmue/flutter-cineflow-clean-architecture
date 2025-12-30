import 'package:cineflow/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../entity/movie.dart';

abstract interface class MovieRepository {
  Future<Either<Failure, List<Movie>>> getReleaseMovies({
    required String apiKey,
  });
}
