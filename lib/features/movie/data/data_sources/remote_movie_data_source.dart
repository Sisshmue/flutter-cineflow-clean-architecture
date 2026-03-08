import 'package:cineflow/core/services/api_service.dart';
import 'package:cineflow/features/movie/data/model/movie_detail_model.dart';
import 'package:cineflow/features/movie/data/model/movie_model.dart';
import '../../domain/entity/movie.dart';
import '../../domain/entity/movie_detail.dart';

abstract interface class RemoteMovieDataSource {
  Future<List<MovieModel>> getMovie({required String apiKey});
  Future<List<SearchMovieModel>> searchMovie({required String keyWord});
  Future<MovieDetailModel> getMovieDetail({required int movieId});
}

class RemoteMovieDataSourceImpl implements RemoteMovieDataSource {
  @override
  Future<List<MovieModel>> getMovie({required String apiKey}) async {
    print('Its actually loading the movies');
    final res = await ApiService.apiGet('/trending/all/day');
    if (res['results'] is List) {
      return res['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
    } else {
      throw 'Response is not a list or Error in data layer';
    }
  }

  @override
  Future<List<SearchMovieModel>> searchMovie({required String keyWord}) async {
    final url = Uri(
      path: '/search/multi',
      queryParameters: {
        'query': keyWord,
        'include_adult': 'true',
        'language': 'en',
        'page': '1',
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

  @override
  Future<MovieDetailModel> getMovieDetail({required int movieId}) async {
    final url = Uri(path: '/movie/$movieId');
    final res = await ApiService.apiGet(url.toString());
    return MovieDetailModel.fromJson(res);
  }
}
