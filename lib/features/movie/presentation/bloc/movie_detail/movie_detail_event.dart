part of 'movie_detail_bloc.dart';

class MovieDetailEvent {}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int movieId;
  final String type;
  GetMovieDetailEvent({required this.movieId, required this.type});
}
