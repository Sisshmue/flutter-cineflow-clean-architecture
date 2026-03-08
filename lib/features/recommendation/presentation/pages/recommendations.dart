import 'package:cineflow/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:cineflow/features/movie/presentation/pages/movie_detail.dart';
import 'package:cineflow/features/recommendation/presentation/bloc/recommendation_bloc.dart';
import 'package:cineflow/features/recommendation/presentation/widgets/genre_chip.dart';
import 'package:cineflow/features/recommendation/presentation/widgets/recommendations_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/recommendation_card.dart';
import '../widgets/recommendation_loading.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  final TextEditingController _controller = TextEditingController();
  bool showChips = false;

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    _controller.clear();
    setState(() {
      showChips = false;
    });
    context.read<RecommendationBloc>().add(
      GetRecommendationEvent(parameter: text, notGenre: false),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showChips = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is MovieSuccess && state.fromRecommendation == true) {
              final movieId = state.movieList[0].id;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movieId: movieId),
                ),
              );
            }
            if (state is MovieFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<RecommendationBloc, RecommendationState>(
                  builder: (context, state) {
                    if (state is RecommendationInitial) {
                      return const Center(
                        child: Text('Type a genre to get started!'),
                      );
                    }
                    if (state is RecommendationLoading) {
                      return RecommendationLoadingWidget();
                    }

                    if (state is RecommendationSuccess) {
                      return ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: state.recomList.length,
                        itemBuilder: (context, index) {
                          final movie = state.recomList[index];

                          return GestureDetector(
                            onTap: () {
                              context.read<MovieBloc>().add(
                                SearchMoviesEvent(
                                  keyWord: movie.title,
                                  fromRecommendation: true,
                                ),
                              );
                            },
                            child: RecommendationCard(
                              title: movie.title,
                              year: movie.year,
                              description: movie.description,
                            ),
                          );
                        },
                      );
                    }
                    return SizedBox.shrink();
                  },
                  listener: (context, state) {
                    if (state is RecommendationFail) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                ),
              ),
              if (showChips) GenreChip(sendMessage: _sendMessage),
              RecommendationsInput(
                controller: _controller,
                sendMessage: _sendMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
