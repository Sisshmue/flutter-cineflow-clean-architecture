import '../../domain/entity/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  MovieDetailModel({
    required super.title,
    required super.description,
    required super.genres,
    required super.popularity,
    required super.status,
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
    );
  }
}
