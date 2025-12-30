import 'package:cineflow/features/movie/domain/usecases/get_released_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetReleasedMovies _getReleasedMovies;
  final String apiKey;
  MovieBloc({required GetReleasedMovies getReleaseMovies, required this.apiKey})
    : _getReleasedMovies = getReleaseMovies,
      super(MovieInitial()) {
    on<GetMovieRelease>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await _getReleasedMovies(
          SearchMovieParam(apiKey: apiKey),
        );
        movies.fold(
          (failure) => emit(MovieFailure(message: failure.message)),
          (movies) => emit(MovieSuccess(movieList: movies)),
        );
      } catch (e) {
        emit(MovieFailure(message: e.toString()));
      }
    });
  }
}
