import 'package:cineflow/features/movie/domain/entity/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.title,
    required super.releaseDate,
    required super.rating,
    required super.id,
    required super.type,
    required super.posterUrl,
  });

  factory MovieModel.fromJson(dynamic map) {
    return MovieModel(
      title: map['title'] ?? "",
      releaseDate: map['source_release_date'] ?? "",
      rating: "",
      id: map['id'],
      type: map['type'],
      posterUrl: map['poster_url'],
    );
  }
}

class SearchMovieModel extends Movie {
  SearchMovieModel({
    required super.title,
    required super.releaseDate,
    required super.rating,
    required super.id,
    required super.type,
    required super.posterUrl,
  });

  factory SearchMovieModel.fromJson(dynamic map) {
    return SearchMovieModel(
      title: map['name'] ?? '',
      releaseDate: map['year']?.toString() ?? '',
      rating: '',
      id: map['id'] ?? 0,
      type: map['tmdb_type'] ?? '',
      posterUrl: '',
    );
  }
}
