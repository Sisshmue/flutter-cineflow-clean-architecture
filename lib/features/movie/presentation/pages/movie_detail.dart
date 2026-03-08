import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/movie_model.dart';
import '../bloc/movie/movie_bloc.dart';
import '../bloc/movie_detail/movie_detail_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(
      GetMovieDetailEvent(movieId: widget.movieId),
    );
    context.read<MovieBloc>().add(
      CheckMovieSavedStatusEvent(movieId: widget.movieId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MovieDetailFail) {
            return Center(child: Text(state.message));
          }

          if (state is MovieDetailSuccess) {
            final movie = state.movieDetail;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 350,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: movie.posterUrl,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.movie, size: 80),
                        ),

                        /// Gradient overlay
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black87],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),

                        /// Title at bottom
                        Positioned(
                          left: 16,
                          bottom: 20,
                          right: 16,
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Movie details
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Genres
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: movie.genres
                              .map(
                                (genre) => Chip(
                                  backgroundColor: Colors.black87,
                                  label: Text(
                                    genre,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                        ),

                        const SizedBox(height: 20),

                        /// Watch Later Button
                        BlocBuilder<MovieBloc, MovieState>(
                          builder: (context, state) {
                            bool isSaved = false;

                            if (state is MovieSavedStatusState) {
                              isSaved = state.isSaved;
                            }
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isSaved
                                      ? Colors.green
                                      : Colors.redAccent,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  final movieModel = MovieModel(
                                    id: widget.movieId,
                                    title: movie.title,
                                    releaseDate: movie.releaseDate,
                                    rating: movie.popularity,
                                    type: movie.status,
                                    posterUrl: movie.posterUrl,
                                  );

                                  if (!isSaved) {
                                    context.read<MovieBloc>().add(
                                      SaveWatchLaterEvent(movie: movieModel),
                                    );
                                  } else {
                                    context.read<MovieBloc>().add(
                                      RemoveWatchLaterEvent(
                                        movieId: widget.movieId,
                                      ),
                                    );
                                  }

                                  context.read<MovieBloc>().add(
                                    CheckMovieSavedStatusEvent(
                                      movieId: widget.movieId,
                                    ),
                                  );
                                },
                                icon: isSaved
                                    ? Icon(Icons.bookmark, color: Colors.white)
                                    : Icon(
                                        Icons.bookmark_add,
                                        color: Colors.white,
                                      ),
                                label: Text(
                                  isSaved
                                      ? "Added to Watch Later"
                                      : "Add to Watch Later",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        /// Overview title
                        const Text(
                          "Overview",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// Description
                        Text(
                          movie.description,
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),

                        const SizedBox(height: 24),

                        /// Info cards
                        Row(
                          children: [
                            Expanded(
                              child: _infoCard(
                                title: "Popularity",
                                value: movie.popularity,
                                icon: Icons.trending_up,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: _infoCard(
                                title: "Status",
                                value: movie.status,
                                icon: Icons.movie_filter,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.redAccent),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
