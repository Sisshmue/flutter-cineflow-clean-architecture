import 'package:cineflow/features/recommendation/domain/usecase/get_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/recommendation.dart';

part 'recommendation_state.dart';
part 'recommendation_event.dart';

class RecommendationBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  final GetRecommendations _getRecommendations;
  RecommendationBloc({required GetRecommendations getRecommendations, required})
    : _getRecommendations = getRecommendations,
      super(RecommendationInitial()) {
    on<GetRecommendationEvent>((event, emit) async {
      emit(RecommendationLoading());
      try {
        final recommendations = await _getRecommendations(
          GetRecommendationsParam(parameter: event.parameter),
        );
        recommendations.fold(
          (l) => emit(RecommendationFail(message: l.message)),
          (r) => emit(RecommendationSuccess(recomList: r)),
        );
      } catch (e) {
        emit(RecommendationFail(message: e.toString()));
      }
    });
  }
}
