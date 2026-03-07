part of 'movie_detail_bloc.dart';

class MovieDetailEvent {}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int movieId;
  GetMovieDetailEvent({required this.movieId});
}
