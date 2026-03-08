import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/core/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../entity/movie.dart';
import '../repository/movie_repository.dart';

class GetSavedMovies implements UseCase<List<Movie>, NoParam> {
  final MovieRepository movieRepository;
  GetSavedMovies({required this.movieRepository});
  @override
  Future<Either<Failure, List<Movie>>> call(NoParam param) {
    return movieRepository.getWatchLaterMovies();
  }
}

class NoParam {}
