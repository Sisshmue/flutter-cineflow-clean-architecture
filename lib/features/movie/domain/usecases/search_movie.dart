import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/features/movie/domain/entity/movie.dart';
import 'package:cineflow/features/movie/domain/repository/movie_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/usecase.dart';

class SearchMovie implements UseCase<Movie, SearchMovieParam> {
  final MovieRepository movieRepository;

  SearchMovie({required this.movieRepository});

  @override
  Future<Either<Failure, Movie>> call(SearchMovieParam params) async {
    return await movieRepository.searchMovie(keyword: params.keyword);
  }
}

class SearchMovieParam {
  final String keyword;

  SearchMovieParam({required this.keyword});
}
