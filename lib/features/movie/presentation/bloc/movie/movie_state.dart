part of 'movie_bloc.dart';

class MovieState {}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieSuccess extends MovieState {
  final List<Movie> movieList;
  bool fromRecommendation;

  MovieSuccess({required this.movieList, this.fromRecommendation = false});
}

final class MovieFailure extends MovieState {
  final String message;
  MovieFailure({required this.message});
}

class MovieSavedStatusState extends MovieState {
  final bool isSaved;
  MovieSavedStatusState({required this.isSaved});
}
