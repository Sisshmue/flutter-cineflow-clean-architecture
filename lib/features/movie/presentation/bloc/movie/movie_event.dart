part of 'movie_bloc.dart';

class MovieEvent {}

class GetMovieRelease extends MovieEvent {
  final int page;
  GetMovieRelease({required this.page});
}

class SearchMoviesEvent extends MovieEvent {
  final String keyWord;
  bool fromRecommendation;
  final int page;
  SearchMoviesEvent({required this.keyWord, this.fromRecommendation = false, required this.page});
}

class SaveWatchLaterEvent extends MovieEvent {
  final Movie movie;

  SaveWatchLaterEvent({required this.movie});
}

class RemoveWatchLaterEvent extends MovieEvent {
  final int movieId;

  RemoveWatchLaterEvent({required this.movieId});
}

class GetWatchLaterMoviesEvent extends MovieEvent {}

class CheckMovieSavedStatusEvent extends MovieEvent {
  final int movieId;
  CheckMovieSavedStatusEvent({required this.movieId});
}
