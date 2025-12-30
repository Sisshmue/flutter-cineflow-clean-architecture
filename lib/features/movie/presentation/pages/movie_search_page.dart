import 'package:cineflow/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/movie.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_search_bar.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MovieBloc>().add(GetMovieRelease());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: BlocConsumer<MovieBloc, MovieState>(
            listener: (context, state) {
              if (state is MovieFailure) {
                print('Error');
                print(state.message);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is MovieSuccess) {
                print(state.movieList);
              }
            },
            builder: (context, state) {
              if (state is MovieLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is MovieSuccess) {
                return CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: MovieSearchBar(),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 columns
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.7, // Rectangular portrait shape
                          ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            MovieCard(movie: state.movieList[index]),
                        childCount: state.movieList.length,
                      ),
                    ),
                  ],
                );
              }
              return Center();
            },
          ),
        ),
      ),
    );
  }
}
