import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/features/recommendation/data/data_sources/remote_data_recommendation_source.dart';
import 'package:cineflow/features/recommendation/domain/entity/recommendation.dart';
import 'package:cineflow/features/recommendation/domain/repository/recommendation_repository.dart';
import 'package:fpdart/src/either.dart';

class RecommendationImpl implements RecommendationRepository {
  final RemoteDataRecommendationSource remoteDataRecommendationSource;
  RecommendationImpl({required this.remoteDataRecommendationSource});
  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendation({
    required String parameter,
    required bool notGenre,
  }) async {
    try {
      final response = await remoteDataRecommendationSource.getRecommendations(
        parameter: parameter,
        notGenre: notGenre,
      );
      return right(response);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
