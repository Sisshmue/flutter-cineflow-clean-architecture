import 'package:cineflow/core/theme/pallete.dart';
import 'package:cineflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cineflow/features/auth/presentation/pages/sign_up.dart';
import 'package:cineflow/features/auth/presentation/widgets/auth_field.dart';
import 'package:cineflow/features/movie/presentation/pages/movie_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              Widgets.showSnackBar(
                context,
                'Error Logging In. Please try again!',
              );
            }

            if (state is AuthSuccess) {
              Navigator.push(context, MovieSearchPage.route());
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is AuthFailure) {
              return Center(child: Text('Error Please try again later'));
            }

            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.movie_filter,
                    size: 80,
                    color: Pallete.primaryRed,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  AuthField(
                    hintText: "Email",
                    icon: Icons.email,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  AuthField(
                    hintText: "Password",
                    icon: Icons.lock,
                    isPassword: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Pallete.primaryRed,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthLogIn(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "LOG IN",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.push(context, SignUpPage.route()),
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: Pallete.textSecondary),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
