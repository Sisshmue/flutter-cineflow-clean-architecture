import 'package:cached_network_image/cached_network_image.dart';
import 'package:cineflow/core/theme/pallete.dart';
import 'package:cineflow/features/movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedMoviesPage extends StatefulWidget {
  const SavedMoviesPage({super.key});

  @override
  State<SavedMoviesPage> createState() => _SavedMoviesPageState();
}

class _SavedMoviesPageState extends State<SavedMoviesPage> {
  @override
  void initState() {
    super.initState();

    context.read<MovieBloc>().add(GetWatchLaterMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.background,
      appBar: AppBar(
        title: const Text("Saved Movies"),
        backgroundColor: Pallete.background,
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MovieFailure) {
            return Center(child: Text(state.message));
          }

          if (state is GetSavedMoviesSuccessState) {
            if (state.movieList.isEmpty) {
              return const Center(
                child: Text(
                  "No saved movies yet",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.movieList.length,
              itemBuilder: (context, index) {
                final movie = state.movieList[index];

                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: movie.posterUrl,
                    width: 50,
                    fit: BoxFit.cover,
                  ),

                  title: Text(
                    movie.title,
                    style: const TextStyle(color: Colors.white),
                  ),

                  subtitle: Text(
                    movie.releaseDate,
                    style: const TextStyle(color: Colors.white70),
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      context.read<MovieBloc>().add(
                        RemoveWatchLaterEvent(movieId: movie.id),
                      );

                      context.read<MovieBloc>().add(GetWatchLaterMoviesEvent());
                    },
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
