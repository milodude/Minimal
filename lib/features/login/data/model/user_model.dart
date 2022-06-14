import 'package:coda_test/features/login/domain/entities/user_info.dart';

class UserModel extends UserInfo {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.photo,
    required super.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> user) {
    return UserModel(
      id: user['response']['id'],
      firstName: user['response']['firstName'] ?? '',
      lastName: user['response']['lastName'] ?? '',
      email: user['response']['email'] ?? '',
      photo: user['response']['photo'] ?? '',
      accessToken: user['response']['accessToken'] ?? '',
    );
  }
}
