import 'package:cineflow/core/theme/app_theme.dart';
import 'package:cineflow/features/movie/data/data_sources/remote_movie_data_source.dart';
import 'package:cineflow/features/movie/data/respository/movie_repository_impl.dart';
import 'package:cineflow/features/movie/domain/usecases/get_released_movies.dart';
import 'package:cineflow/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:cineflow/features/movie/presentation/pages/movie_search_page.dart';
import 'package:cineflow/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<MovieBloc>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CineFlow',
      theme: AppTheme.cineFlowTheme,
      home: const MovieSearchPage(),
    );
  }
}
