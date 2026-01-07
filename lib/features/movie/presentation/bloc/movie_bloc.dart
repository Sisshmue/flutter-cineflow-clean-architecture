import 'package:cineflow/features/movie/domain/usecases/get_released_movies.dart';
import 'package:cineflow/features/movie/domain/usecases/search_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetReleasedMovies _getReleasedMovies;
  final SearchMovies _searchMovies;
  final String apiKey;
  MovieBloc({
    required GetReleasedMovies getReleaseMovies,
    required this.apiKey,
    required SearchMovies searchMovies,
  }) : _getReleasedMovies = getReleaseMovies,
       _searchMovies = searchMovies,
       super(MovieInitial()) {
    on<GetMovieRelease>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await _getReleasedMovies(
          GetReleasedMovieParam(apiKey: apiKey),
        );
        movies.fold(
          (failure) => emit(MovieFailure(message: failure.message)),
          (movies) => emit(MovieSuccess(movieList: movies)),
        );
      } catch (e) {
        emit(MovieFailure(message: e.toString()));
      }
    });

    on<SearchMoviesEvent>((event, emit) async {
      emit(MovieLoading());
      try {
        final response = await _searchMovies(
          SearchMoviesParams(apiKey: apiKey, keyWord: event.keyWord),
        );

        response.fold(
          (l) => emit(MovieFailure(message: l.message)),
          (r) => emit(MovieSuccess(movieList: r)),
        );
      } catch (e) {
        emit(MovieFailure(message: e.toString()));
      }
    });
  }
}
