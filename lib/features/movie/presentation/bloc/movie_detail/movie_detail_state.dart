part of 'movie_detail_bloc.dart';

class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailSuccess extends MovieDetailState {
  final MovieDetail movieDetail;
  MovieDetailSuccess({required this.movieDetail});
}

class MovieDetailFail extends MovieDetailState {
  final String message;
  MovieDetailFail({required this.message});
}
