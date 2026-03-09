import 'package:cineflow/features/movie/domain/usecases/get_released_movies.dart';
import 'package:cineflow/features/movie/domain/usecases/get_saved_movies.dart';
import 'package:cineflow/features/movie/domain/usecases/is_movie_saved.dart';
import 'package:cineflow/features/movie/domain/usecases/remove_saved_movie.dart';
import 'package:cineflow/features/movie/domain/usecases/save_to_watch_later.dart';
import 'package:cineflow/features/movie/domain/usecases/search_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetReleasedMovies _getReleasedMovies;
  final SearchMovies _searchMovies;
  final GetSavedMovies _getSavedMovies;
  final RemoveSavedMovie _removeSavedMovie;
  final SaveToWatchLater _saveToWatchLater;
  final IsMovieSaved _isMovieSaved;
  final String apiKey;
  MovieBloc({
    required GetReleasedMovies getReleaseMovies,
    required GetSavedMovies getSavedMovies,
    required RemoveSavedMovie removeSaveMovies,
    required SaveToWatchLater saveToWatchLater,
    required IsMovieSaved isMovieSaved,
    required this.apiKey,
    required SearchMovies searchMovies,
  }) : _getReleasedMovies = getReleaseMovies,
       _searchMovies = searchMovies,
       _getSavedMovies = getSavedMovies,
       _removeSavedMovie = removeSaveMovies,
       _saveToWatchLater = saveToWatchLater,
       _isMovieSaved = isMovieSaved,
       super(MovieInitial()) {
    on<GetMovieRelease>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await _getReleasedMovies(
          GetReleasedMovieParam(page: event.page),
        );
        movies.fold(
          (failure) => emit(MovieFailure(message: failure.message)),
          (movies) =>
              emit(MovieSuccess(movieList: movies, fromRecommendation: false)),
        );
      } catch (e) {
        emit(MovieFailure(message: e.toString()));
      }
    });

    on<SearchMoviesEvent>((event, emit) async {
      emit(MovieLoading());
      try {
        final response = await _searchMovies(
          SearchMoviesParams(
            apiKey: apiKey,
            keyWord: event.keyWord,
            page: event.page,
          ),
        );

        response.fold(
          (l) => emit(MovieFailure(message: l.message)),
          (r) => emit(
            MovieSuccess(
              movieList: r,
              fromRecommendation: event.fromRecommendation,
            ),
          ),
        );
      } catch (e) {
        emit(MovieFailure(message: e.toString()));
      }
    });

    on<SaveWatchLaterEvent>((event, emit) async {
      try {
        await _saveToWatchLater(SaveToWatchLaterParams(movie: event.movie));
      } catch (e) {
        emit(MovieFailure(message: e.toString()));
      }
    });

    on<RemoveWatchLaterEvent>((event, emit) async {
      try {
        await _removeSavedMovie(RemoveSavedMovieParam(movieId: event.movieId));
      } catch (e) {
        emit(MovieFailure(message: e.toString()));
      }
    });

    on<GetWatchLaterMoviesEvent>((event, emit) async {
      emit(MovieLoading());

      try {
        final response = await _getSavedMovies(NoParam());
        response.fold(
          (l) => emit(MovieFailure(message: l.message)),
          (r) => emit(GetSavedMoviesSuccessState(movieList: r)),
        );
      } catch (e) {
        emit(MovieFailure(message: e.toString()));
      }
    });

    on<CheckMovieSavedStatusEvent>((event, emit) async {
      final result = await _isMovieSaved(
        RemoveSavedMovieParam(movieId: event.movieId),
      );

      result.fold(
        (failure) => emit(MovieFailure(message: failure.message)),
        (isSaved) => emit(MovieSavedStatusState(isSaved: isSaved)),
      );
    });
  }
}
