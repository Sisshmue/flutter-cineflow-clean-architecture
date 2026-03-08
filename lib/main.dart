import 'package:cineflow/core/theme/app_theme.dart';
import 'package:cineflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cineflow/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:cineflow/features/movie/presentation/bloc/movie/movie_bloc.dart';
import 'package:cineflow/features/movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:cineflow/features/recommendation/data/data_sources/remote_data_recommendation_source.dart';
import 'package:cineflow/features/recommendation/data/repositroy/recommendation_impl.dart';
import 'package:cineflow/features/recommendation/domain/usecase/get_recommendations.dart';
import 'package:cineflow/features/recommendation/presentation/bloc/recommendation_bloc.dart';
import 'package:cineflow/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'features/movie/data/model/movie_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieModelAdapter());
  await Hive.openBox<MovieModel>('watch_later_movies');
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<MovieBloc>()),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>()..add(AuthCheckRequest()),
        ),
        BlocProvider(create: (_) => serviceLocator<RecommendationBloc>()),
        BlocProvider(create: (_) => serviceLocator<MovieDetailBloc>()),
      ],
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
      home: const AuthWrapper(),
    );
  }
}
