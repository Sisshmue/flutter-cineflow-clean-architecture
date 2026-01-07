import 'package:cineflow/features/auth/domain/entity/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['user_metadata']['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
