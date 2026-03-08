import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/core/usecase.dart';
import 'package:cineflow/features/movie/data/model/movie_model.dart';
import 'package:cineflow/features/movie/domain/repository/movie_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entity/movie.dart';

class SaveToWatchLater implements UseCase<void, SaveToWatchLaterParams> {
  final MovieRepository movieRepository;
  SaveToWatchLater({required this.movieRepository});
  @override
  Future<Either<Failure, void>> call(SaveToWatchLaterParams params) {
    return movieRepository.saveMovieToWatchLater(movie: params.movie);
  }
}

class SaveToWatchLaterParams {
  final Movie movie;
  SaveToWatchLaterParams({required this.movie});
}
