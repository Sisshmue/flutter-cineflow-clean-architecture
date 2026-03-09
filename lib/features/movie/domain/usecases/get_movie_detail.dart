import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/core/usecase.dart';
import 'package:cineflow/features/movie/domain/repository/movie_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../entity/movie_detail.dart';

class GetMovieDetail implements UseCase<MovieDetail, GetMovieDetailParams> {
  final MovieRepository movieRepository;
  GetMovieDetail({required this.movieRepository});
  @override
  Future<Either<Failure, MovieDetail>> call(GetMovieDetailParams params) {
    return movieRepository.getMovieDetail(
      movieId: params.movieId,
      type: params.type,
    );
  }
}

class GetMovieDetailParams {
  final int movieId;
  final String type;
  GetMovieDetailParams({required this.movieId, required this.type});
}
