import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/features/recommendation/domain/entity/recommendation.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RecommendationRepository {
  Future<Either<Failure, List<Recommendation>>> getRecommendation({
    required String parameter,
    required bool notGenre,
  });
}
