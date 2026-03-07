import 'package:cineflow/core/services/api_service.dart';
import 'package:cineflow/features/movie/data/model/movie_model.dart';

abstract interface class RemoteMovieDataSource {
  Future<List<MovieModel>> getMovie({required String apiKey});
  Future<List<SearchMovieModel>> searchMovie({
    required String keyWord,
    required String apiKey,
  });
}

class RemoteMovieDataSourceImpl implements RemoteMovieDataSource {
  @override
  Future<List<MovieModel>> getMovie({required String apiKey}) async {
    print('Its actually loading the movies');
    final res = await ApiService.apiGet('/movie/popular?page=1');
    if (res['results'] is List) {
      return res['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
    } else {
      throw 'Response is not a list or Error in data layer';
    }
  }

  @override
  Future<List<SearchMovieModel>> searchMovie({
    required String keyWord,
    required String apiKey,
  }) async {
    final url = Uri(
      path: '/search/movie',
      queryParameters: {
        'query': keyWord,
        'include_adult': 'true',
        'language': 'en',
        'page': 1,
      },
    );

    final res = await ApiService.apiGet(url.toString());

    if (res['results'] is List && res['results'].isNotEmpty) {
      return res['results']
          .map<SearchMovieModel>((json) => SearchMovieModel.fromJson(json))
          .toList();
    } else {
      throw 'Cannot search the movies related to $keyWord';
    }
  }
}
