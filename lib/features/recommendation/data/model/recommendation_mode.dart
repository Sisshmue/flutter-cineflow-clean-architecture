import 'package:cineflow/features/recommendation/domain/entity/recommendation.dart';

class RecommendationModel extends Recommendation {
  RecommendationModel({
    required super.id,
    required super.title,
    required super.description,
    required super.image,
    required super.year,
  });

  factory RecommendationModel.fromJson(dynamic json) {
    return RecommendationModel(
      id: json['id'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      image: json['image'].toString(),
      year: json['year'].toString(),
    );
  }
}
