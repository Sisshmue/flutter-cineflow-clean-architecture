import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineflow/features/recommendation/presentation/bloc/recommendation_bloc.dart';
import 'package:cineflow/features/recommendation/presentation/widgets/genre_chip.dart';
import 'package:cineflow/features/recommendation/presentation/widgets/recommendations_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
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
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.redAccent),
                    );
                  }
                  if (state is RecommendationSuccess) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.recomList.length,
                      itemBuilder: (context, index) {
                        final movie = state.recomList[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    12,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: movie.image,
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
                                            CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.movie),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    "${movie.title} (${movie.year})",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(movie.description),
                                ),
                              ),
                            ],
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
    );
  }
}
