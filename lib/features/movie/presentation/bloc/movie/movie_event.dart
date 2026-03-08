part of 'movie_bloc.dart';

class MovieEvent {}

class GetMovieRelease extends MovieEvent {}

class SearchMoviesEvent extends MovieEvent {
  final String keyWord;
  bool fromRecommendation;
  SearchMoviesEvent({required this.keyWord, this.fromRecommendation = false});
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
