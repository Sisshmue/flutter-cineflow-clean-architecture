import '../../domain/entity/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  MovieDetailModel({
    required super.title,
    required super.description,
    required super.genres,
    required super.popularity,
    required super.status,
    required super.posterUrl,
    required super.releaseDate,
  });

  factory MovieDetailModel.fromJson(dynamic json) {
    return MovieDetailModel(
      title: json['original_title'],
      description: json['overview'],
      genres: (json['genres'] as List)
          .map((genre) => genre['name'] as String)
          .toList(),
      popularity: json['popularity'].toString(),
      status: json['status'],
      posterUrl: 'https://image.tmdb.org/t/p/w500/${json['poster_path']}',
      releaseDate: json['release_date'],
    );
  }
}
