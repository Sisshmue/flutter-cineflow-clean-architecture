part of 'recommendation_bloc.dart';

class RecommendationEvent {}

class GetRecommendationEvent extends RecommendationEvent {
  final String parameter;
  final bool notGenre;
  GetRecommendationEvent({required this.parameter, required this.notGenre});
}
