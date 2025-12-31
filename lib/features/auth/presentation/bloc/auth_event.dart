part of 'auth_bloc.dart';

class AuthEvent {}

class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUp({required this.name, required this.email, required this.password});
}

class AuthLogIn extends AuthEvent {
  final String email;
  final String password;

  AuthLogIn({required this.email, required this.password});
}

class AuthCheckRequest extends AuthEvent {}
