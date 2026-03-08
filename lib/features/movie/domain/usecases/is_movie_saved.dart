import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/core/usecase.dart';
import 'package:cineflow/features/movie/domain/usecases/remove_saved_movie.dart';
import 'package:fpdart/fpdart.dart';
import '../repository/movie_repository.dart';

class IsMovieSaved implements UseCase<bool, RemoveSavedMovieParam> {
  final MovieRepository movieRepository;
  IsMovieSaved({required this.movieRepository});
  @override
  Future<Either<Failure, bool>> call(RemoveSavedMovieParam params) {
    return movieRepository.isMovieInWatchLater(params.movieId);
  }
}
