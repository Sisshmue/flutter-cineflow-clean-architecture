part of 'movie_bloc.dart';

class MovieEvent {}

class GetMovieRelease extends MovieEvent {}

class SearchMoviesEvent extends MovieEvent {
  final String keyWord;
  bool fromRecommendation;
  SearchMoviesEvent({required this.keyWord, this.fromRecommendation = false});
}
