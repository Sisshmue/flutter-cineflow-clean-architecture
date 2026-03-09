import 'package:cineflow/core/theme/pallete.dart';
import 'package:cineflow/features/movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity/movie.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_grid_skeleton.dart';
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
  final _searchController = TextEditingController();
  bool _isFirstLoaded = true;
  List<Movie> movies = [];
  int page = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MovieBloc>().add(GetMovieRelease(page: page));

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      addPagination();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    if (_scrollController.hasClients) {
      _searchController.clear();
      if (_scrollController.offset == 0) {
        _isFirstLoaded = true;
        context.read<MovieBloc>().add(GetMovieRelease(page: page));
      } else {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  void addPagination() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      setState(() {
        isLoadingMore = true;
      });
      if (currentScroll >= (maxScroll - 200)) {
        context.read<MovieBloc>().add(GetMovieRelease(page: page++));
      }
      setState(() {
        isLoadingMore = false;
      });
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
                return const MovieGridSkeleton();
              }

              if (state is MovieFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.primaryRed,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          context.read<MovieBloc>().add(
                            GetMovieRelease(page: page),
                          );
                        },
                        child: const Text(
                          'Retry',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (state is MovieSuccess && state.fromRecommendation == false) {
                _isFirstLoaded = false;
                movies.addAll(state.movieList);
              }
              if (movies.isNotEmpty ||
                  (state is MovieLoading && !_isFirstLoaded)) {
                return RefreshIndicator(
                  color: Pallete.primaryRed,
                  backgroundColor: Pallete.surface,
                  onRefresh: () async {
                    context.read<MovieBloc>().add(GetMovieRelease(page: page));
                    await context.read<MovieBloc>().stream.firstWhere(
                      (state) => state is MovieSuccess || state is MovieFailure,
                    );
                    _searchController.clear();
                  },
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: MovieSearchBar(
                            searchController: _searchController,
                          ),
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
                          (context, index) {
                            if (index >= movies.length) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Pallete.primaryRed,
                                  ),
                                ),
                              );
                            }
                            return MovieCard(movie: movies[index]);
                          },
                          childCount: isLoadingMore
                              ? movies.length + 1
                              : movies.length,
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
