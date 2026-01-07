import 'package:cineflow/core/theme/pallete.dart';
import 'package:cineflow/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/movie.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_search_bar.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  static MaterialPageRoute<dynamic> route() =>
      (MaterialPageRoute(builder: (context) => MovieSearchPage()));

  @override
  State<MovieSearchPage> createState() => MovieSearchPageState();
}

class MovieSearchPageState extends State<MovieSearchPage> {
  final _scrollController = ScrollController();
  bool _isFirstLoaded = true;
  List<Movie> movies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MovieBloc>().add(GetMovieRelease());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  void scrollToTop() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset == 0) {
        _isFirstLoaded = true;
        context.read<MovieBloc>().add(GetMovieRelease());
      } else {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
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
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is MovieLoading && _isFirstLoaded) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is MovieFailure) {
                return Center(
                  child: Text('Something is wrong, Please try again!'),
                );
              }

              if (state is MovieSuccess) {
                _isFirstLoaded = false;
                movies = state.movieList;
              }
              if (movies.isNotEmpty ||
                  (state is MovieLoading && !_isFirstLoaded)) {
                return RefreshIndicator(
                  color: Pallete.primaryRed,
                  backgroundColor: Pallete.surface,
                  onRefresh: () async {
                    context.read<MovieBloc>().add(GetMovieRelease());

                    await context.read<MovieBloc>().stream.firstWhere(
                      (state) => state is MovieSuccess || state is MovieFailure,
                    );
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
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
                              childAspectRatio:
                                  0.7, // Rectangular portrait shape
                            ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => MovieCard(movie: movies[index]),
                          childCount: movies.length,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
