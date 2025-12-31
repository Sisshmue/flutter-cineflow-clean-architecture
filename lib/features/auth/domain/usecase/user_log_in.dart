import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/features/auth/domain/entity/user.dart';
import 'package:cineflow/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogIn {
  final AuthRepository authRepository;

  UserLogIn({required this.authRepository});

  Future<Either<Failure, User>> call(LoginParam params) {
    return authRepository.userLogin(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParam {
  final String email;
  final String password;

  LoginParam({required this.email, required this.password});
}
