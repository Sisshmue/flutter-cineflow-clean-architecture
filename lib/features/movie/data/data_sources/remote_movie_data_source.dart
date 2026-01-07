import 'dart:convert';
import 'dart:math';

import 'package:cineflow/core/secrets/secrets_data.dart';
import 'package:cineflow/core/services/api_service.dart';
import 'package:cineflow/features/movie/data/model/movie_model.dart';
import 'package:http/http.dart' as http;

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
    final res = await ApiService.apiGet('/releases/?apiKey=$apiKey&limit=11');
    if (res['releases'] is List) {
      return res['releases']
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
