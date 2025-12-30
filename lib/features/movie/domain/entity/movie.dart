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

// Hardcoded list of 9 movies
const List<Movie> dummyMovies = [
  Movie(
    id: 1,
    title: "Inception",
    type: "Movie",
    posterUrl: "",
    releaseDate: "2010-07-16",
    rating: "8.8",
  ),
  Movie(
    id: 2,
    title: "The Dark Knight",
    type: "Movie",
    posterUrl: "",
    releaseDate: "2008-07-18",
    rating: "9.0",
  ),
  Movie(
    id: 3,
    title: "Interstellar",
    type: "Movie",
    posterUrl: "",
    releaseDate: "2014-11-07",
    rating: "8.7",
  ),
  Movie(
    id: 4,
    title: "Pulp Fiction",
    type: "Movie",
    posterUrl: "",
    releaseDate: "1994-10-14",
    rating: "8.9",
  ),
  Movie(
    id: 5,
    title: "The Matrix",
    type: "Movie",
    posterUrl: "",
    releaseDate: "1999-03-31",
    rating: "8.7",
  ),
  Movie(
    id: 6,
    title: "Gladiator",
    type: "Movie",
    posterUrl: "",
    releaseDate: "2000-05-05",
    rating: "8.5",
  ),
  Movie(
    id: 7,
    title: "The Godfather",
    type: "Movie",
    posterUrl: "",
    releaseDate: "1972-03-24",
    rating: "9.2",
  ),
  Movie(
    id: 8,
    title: "Seven",
    type: "Movie",
    posterUrl: "",
    releaseDate: "1995-09-22",
    rating: "8.6",
  ),
  Movie(
    id: 9,
    title: "The Prestige",
    type: "Movie",
    posterUrl: "",
    releaseDate: "2006-10-20",
    rating: "8.5",
  ),
];
