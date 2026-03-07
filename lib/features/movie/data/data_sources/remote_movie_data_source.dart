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
    final res = await ApiService.apiGet(
      '/search/?apiKey=$apiKey&search_field=name&search_value=$keyWord',
    );

    print(res);
    print(res['title_results'][0]);
    if (res['title_results'] is List && res['title_results'].isNotEmpty) {
      print(
        res['title_results']
            .map<SearchMovieModel>((json) => SearchMovieModel.fromJson(json))
            .toList(),
      );
      return res['title_results']
          .map<SearchMovieModel>((json) => SearchMovieModel.fromJson(json))
          .toList();
    } else {
      throw res['statusMessage'];
    }
  }
}
