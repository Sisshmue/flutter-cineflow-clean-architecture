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
      title: map['media_type'] == 'tv' ? map['name'] : map['title'] ?? "",
      releaseDate: map['media_type'] == 'tv'
          ? map['first_air_date']
          : map['release_date'] ?? "",
      rating: "${map['vote_average']}(${map['vote_count']})",
      id: map['id'] ?? '',
      type: map['media_type'],
      posterUrl: map['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${map['poster_path']}'
          : '',
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
      title: map['media_type'] == 'tv' ? map['name'] : map['title'] ?? "",
      releaseDate: map['media_type'] == 'tv'
          ? map['first_air_date']
          : map['release_date'] ?? "",
      rating: "${map['vote_average']} (${map['vote_count']})",
      id: map['id'] ?? 0,
      type: map['media_type'],
      posterUrl: map['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${map['poster_path']}'
          : '',
    );
  }
}
