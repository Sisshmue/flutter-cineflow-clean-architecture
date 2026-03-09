import 'package:cineflow/core/services/api_service.dart';
import 'package:cineflow/features/movie/data/model/movie_detail_model.dart';
import 'package:cineflow/features/movie/data/model/movie_model.dart';

import '../../domain/entity/movie_detail.dart';

abstract interface class RemoteMovieDataSource {
  Future<List<MovieModel>> getMovie({required int page});
  Future<List<SearchMovieModel>> searchMovie({required String keyWord, required int page});
  Future<MovieDetail> getMovieDetail({
    required int movieId,
    required String type,
  });
}

class RemoteMovieDataSourceImpl implements RemoteMovieDataSource {
  @override
  Future<List<MovieModel>> getMovie({required int page}) async {
    print('Its actually loading the movies');
    final res = await ApiService.apiGet('/trending/all/day?page=$page');
    if (res['results'] is List) {
      return res['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
    } else {
      throw 'Response is not a list or Error in data layer';
    }
  }

  @override
  Future<List<SearchMovieModel>> searchMovie({required String keyWord, required int page}) async {
    final url = Uri(
      path: '/search/multi',
      queryParameters: {
        'query': keyWord,
        'include_adult': 'true',
        'language': 'en',
        'page': '$page',
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
  Future<MovieDetail> getMovieDetail({
    required int movieId,
    required String type,
  }) async {
    final url = type == 'movie'
        ? Uri(path: '/movie/$movieId')
        : Uri(path: '/tv/$movieId');
    final res = await ApiService.apiGet(url.toString());
    return type == 'movie'
        ? MovieDetailModel.fromJson(res)
        : TvDetailModel.fromJson(res);
  }
}
