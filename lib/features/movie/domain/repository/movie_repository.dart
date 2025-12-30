import 'package:cineflow/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../entity/movie.dart';

abstract interface class MovieRepository {
  Future<Either<Failure, Movie>> searchMovie({required String keyword});
}
