part of 'movie_bloc.dart';

class MovieEvent {}

class GetMovieRelease extends MovieEvent {}

class SearchMoviesEvent extends MovieEvent {
  final String keyWord;
  SearchMoviesEvent({required this.keyWord});
}
