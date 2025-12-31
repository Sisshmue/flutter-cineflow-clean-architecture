import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/features/auth/domain/entity/user.dart';
import 'package:cineflow/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp {
  final AuthRepository authRepository;

  UserSignUp({required this.authRepository});

  Future<Either<Failure, User>> call(SignUpParam params) async {
    return await authRepository.userSignUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParam {
  final String name;
  final String email;
  final String password;

  SignUpParam({
    required this.name,
    required this.email,
    required this.password,
  });
}
