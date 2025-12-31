import 'package:cineflow/core/theme/app_theme.dart';
import 'package:cineflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cineflow/features/auth/presentation/pages/log_in.dart';
import 'package:cineflow/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:cineflow/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<MovieBloc>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
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
      home: const LoginPage(),
    );
  }
}
