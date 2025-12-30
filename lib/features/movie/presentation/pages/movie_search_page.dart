import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: MovieSearchBar(),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7, // Rectangular portrait shape
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => MovieCard(movie: dummyMovies[index]),
                  childCount: dummyMovies.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
