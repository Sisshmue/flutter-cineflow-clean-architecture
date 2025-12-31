import 'package:cineflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cineflow/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/show_snack_bar.dart';
import '../../../../core/theme/pallete.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (context) => SignUpPage());

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
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
              showSnackBar(context, state.message);
            }

            if (state is AuthSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Icon(
                  //   Icons.movie_filter,
                  //   size: 80,
                  //   color: Pallete.primaryRed,
                  // ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      'assets/image/app_logo_img.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),
                  AuthField(
                    hintText: "Full Name",
                    icon: Icons.person,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 16),
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
                      if (key.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        context.read<AuthBloc>().add(
                          AuthSignUp(
                            name: _nameController.text,
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Already have an account? Log In",
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
