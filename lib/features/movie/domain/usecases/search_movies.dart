import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/core/usecase.dart';
import 'package:cineflow/features/movie/domain/entity/movie.dart';
import 'package:cineflow/features/movie/domain/repository/movie_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchMovies implements UseCase<List<Movie>, SearchMoviesParams> {
  final MovieRepository movieRepository;

  SearchMovies(this.movieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(SearchMoviesParams params) async {
    return await movieRepository.searchMovies(
      keyWord: params.keyWord,
      page: params.page,
    );
  }
}

class SearchMoviesParams {
  final String apiKey;
  final String keyWord;
  final int page;

  SearchMoviesParams({
    required this.apiKey,
    required this.keyWord,
    required this.page,
  });
}
