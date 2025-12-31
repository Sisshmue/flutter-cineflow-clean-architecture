import 'package:cineflow/core/error/failure.dart';
import 'package:cineflow/features/auth/data/data_source/user_remote_data_source.dart';
import 'package:cineflow/features/auth/domain/entity/user.dart';
import 'package:cineflow/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserRemoteDataSource userRemoteDataSource;

  AuthRepositoryImpl({required this.userRemoteDataSource});
  @override
  Future<Either<Failure, User>> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      final user = await userRemoteDataSource.userLogIn(
        email: email,
        password: password,
      );
      return right(user);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> userSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await userRemoteDataSource.userSignUp(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
