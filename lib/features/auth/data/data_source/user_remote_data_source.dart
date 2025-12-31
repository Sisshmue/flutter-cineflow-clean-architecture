import 'package:cineflow/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class UserRemoteDataSource {
  Future<UserModel> userSignUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> userLogIn({
    required String email,
    required String password,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final SupabaseClient client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> userLogIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw 'Server error';
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserModel> userSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw 'Server error';
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw e.toString();
    }
  }
}
