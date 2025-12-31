import 'package:cineflow/core/common/presentaion/main_page.dart';
import 'package:cineflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cineflow/features/auth/presentation/pages/log_in.dart';
import 'package:cineflow/features/movie/presentation/pages/movie_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/show_snack_bar.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AuthSuccess) {
            return const MainPage();
          }
          if (state is UnAuthenticatedState) {
            return const LoginPage();
          }
          if (state is AuthFailure) {
            return const LoginPage();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
