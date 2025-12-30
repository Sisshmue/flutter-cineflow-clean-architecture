part of 'movie_bloc.dart';

class MovieState {}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieSuccess extends MovieState {
  final List<Movie> movieList;

  MovieSuccess({required this.movieList});
}

final class MovieFailure extends MovieState {
  final String message;
  MovieFailure({required this.message});
}
