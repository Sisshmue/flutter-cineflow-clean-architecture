import 'package:cineflow/core/services/api_service.dart';
import 'package:cineflow/features/movie/data/model/movie_model.dart';

abstract interface class RemoteMovieDataSource {
  Future<List<MovieModel>> getMovie({required String apiKey});
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
}
