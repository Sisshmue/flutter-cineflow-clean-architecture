import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/core/usecase.dart';
import 'package:cineflow/features/recommendation/domain/entity/recommendation.dart';
import 'package:cineflow/features/recommendation/domain/repository/recommendation_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetRecommendations
    implements UseCase<List<Recommendation>, GetRecommendationsParam> {
  final RecommendationRepository recommendationRepository;

  GetRecommendations({required this.recommendationRepository});

  @override
  Future<Either<Failure, List<Recommendation>>> call(
    GetRecommendationsParam params,
  ) async {
    return await recommendationRepository.getRecommendation(
      parameter: params.parameter,
      notGenre: params.notGenre,
    );
  }
}

class GetRecommendationsParam {
  final String parameter;
  final bool notGenre;

  GetRecommendationsParam({required this.parameter, required this.notGenre});
}
