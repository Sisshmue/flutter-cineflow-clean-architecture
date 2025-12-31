class Movie {
  final int id;
  final String title;
  final String type;
  final String posterUrl;
  final String releaseDate;
  final String rating;

  const Movie({
    required this.title,
    required this.releaseDate,
    required this.rating,
    required this.id,
    required this.type,
    required this.posterUrl,
  });
}
