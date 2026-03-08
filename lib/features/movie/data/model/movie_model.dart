import 'package:cineflow/features/movie/domain/entity/movie.dart';
import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel extends Movie {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String releaseDate;

  @HiveField(2)
  final String rating;

  @HiveField(3)
  final int id;

  @HiveField(4)
  final String type;

  @HiveField(5)
  final String posterUrl;

  MovieModel({
    required this.title,
    required this.releaseDate,
    required this.rating,
    required this.id,
    required this.type,
    required this.posterUrl,
  }) : super(
         title: title,
         releaseDate: releaseDate,
         rating: rating,
         id: id,
         type: type,
         posterUrl: posterUrl,
       );

  factory MovieModel.fromJson(dynamic map) {
    return MovieModel(
      title: map['media_type'] == 'tv' ? map['name'] : map['title'] ?? "",
      releaseDate: map['media_type'] == 'tv'
          ? map['first_air_date']
          : map['release_date'] ?? "",
      rating: "${map['vote_average']}(${map['vote_count']})",
      id: map['id'] ?? 0,
      type: map['media_type'] ?? "",
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
