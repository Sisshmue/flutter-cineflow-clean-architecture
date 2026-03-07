part of 'movie_detail_bloc.dart';

class MovieDetailEvent {}

class GetMovieDetailEvent extends MovieDetailEvent {
  final String movieId;
  GetMovieDetailEvent({required this.movieId});
}
