import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/features/movie/domain/entity/movie.dart';
import 'package:cineflow/features/movie/domain/repository/movie_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/usecase.dart';

class GetReleasedMovies implements UseCase<List<Movie>, SearchMovieParam> {
  final MovieRepository movieRepository;

  GetReleasedMovies({required this.movieRepository});

  @override
  Future<Either<Failure, List<Movie>>> call(SearchMovieParam params) async {
    return await movieRepository.getReleaseMovies(apiKey: params.apiKey);
  }
}

class SearchMovieParam {
  final String apiKey;

  SearchMovieParam({required this.apiKey});
}
