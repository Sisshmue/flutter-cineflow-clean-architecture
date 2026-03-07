import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/features/movie/domain/entity/movie_detail.dart';
import 'package:cineflow/features/movie/domain/usecases/get_movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  MovieDetailBloc({required GetMovieDetail getMovieDetail})
    : _getMovieDetail = getMovieDetail,
      super(MovieDetailInitial()) {
    on<GetMovieDetailEvent>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        final movieDetail = await _getMovieDetail(
          GetMovieDetailParams(movieId: event.movieId),
        );
        movieDetail.fold(
          (l) => emit(MovieDetailFail(message: l.message)),
          (detail) => emit(MovieDetailSuccess(movieDetail: detail)),
        );
      } catch (e) {
        emit(MovieDetailFail(message: e.toString()));
      }
    });
  }
}
