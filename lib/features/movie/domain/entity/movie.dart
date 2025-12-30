class Movie {
  final String title;
  final String year;
  final String rating;

  const Movie({required this.title, required this.year, required this.rating});
}

// Hardcoded list of 9 movies
const List<Movie> dummyMovies = [
  Movie(title: "Inception", year: "2010", rating: "8.8"),
  Movie(title: "The Dark Knight", year: "2008", rating: "9.0"),
  Movie(title: "Interstellar", year: "2014", rating: "8.7"),
  Movie(title: "Pulp Fiction", year: "1994", rating: "8.9"),
  Movie(title: "The Matrix", year: "1999", rating: "8.7"),
  Movie(title: "Gladiator", year: "2000", rating: "8.5"),
  Movie(title: "The Godfather", year: "1972", rating: "9.2"),
  Movie(title: "Seven", year: "1995", rating: "8.6"),
  Movie(title: "The Prestige", year: "2006", rating: "8.5"),
];
