import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/features/auth/domain/entity/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> userSignUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> userLogin({
    required String email,
    required String password,
  });
}
