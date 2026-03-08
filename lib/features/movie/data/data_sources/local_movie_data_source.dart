import 'package:cineflow/features/movie/data/model/movie_model.dart';
import 'package:hive/hive.dart';
import '../../domain/entity/movie.dart';

abstract class LocalMovieDataSource {
  Future<void> saveMovieToWatchLater({required Movie movie});
  Future<List<Movie>> getWatchLaterMovies();
  Future<void> removeWatchLaterMovie(int movieId);
  Future<bool> isMovieInWatchLater(int movieId);
}

class LocalMovieDataSourceImpl implements LocalMovieDataSource {
  final Box<Movie> movieBox;
  LocalMovieDataSourceImpl({required this.movieBox});

  @override
  Future<List<Movie>> getWatchLaterMovies() async {
    return movieBox.values.toList();
  }

  @override
  Future<void> saveMovieToWatchLater({required Movie movie}) async {
    await movieBox.put(movie.id, movie);
  }

  @override
  Future<void> removeWatchLaterMovie(int movieId) async {
    await movieBox.delete(movieId);
  }

  @override
  Future<bool> isMovieInWatchLater(int movieId) async {
    return movieBox.containsKey(movieId);
  }
}
