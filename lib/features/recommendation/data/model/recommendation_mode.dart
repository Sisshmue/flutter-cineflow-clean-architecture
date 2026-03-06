import 'package:cineflow/features/recommendation/domain/entity/recommendation.dart';

class RecommendationModel extends Recommendation {
  RecommendationModel({
    required super.id,
    required super.title,
    required super.description,
    required super.image,
    required super.year,
  });

  factory RecommendationModel.fromJson(dynamic map) {
    return RecommendationModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      year: map['year'] ?? '',
    );
  }
}
