import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/core/usecase.dart';
import 'package:cineflow/features/movie/data/model/movie_model.dart';
import 'package:cineflow/features/movie/domain/repository/movie_repository.dart';
import 'package:fpdart/fpdart.dart';

class RemoveSavedMovie implements UseCase<void, RemoveSavedMovieParam> {
  final MovieRepository movieRepository;
  RemoveSavedMovie({required this.movieRepository});
  @override
  Future<Either<Failure, void>> call(RemoveSavedMovieParam params) {
    return movieRepository.removeWatchLaterMovie(params.movieId);
  }
}

class RemoveSavedMovieParam {
  final int movieId;
  RemoveSavedMovieParam({required this.movieId});
}
