part of 'recommendation_bloc.dart';

class RecommendationState {}

class RecommendationInitial extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationSuccess extends RecommendationState {
  final List<Recommendation> recomList;
  RecommendationSuccess({required this.recomList});
}

class RecommendationFail extends RecommendationState {
  final String message;
  RecommendationFail({required this.message});
}
