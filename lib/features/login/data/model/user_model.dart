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
    var userModel = UserModel(
      id: user['response']['id'],
      firstName: user['response']['firstname'] ?? '',
      lastName: user['response']['lastname'] ?? '',
      email: user['response']['email'] ?? '',
      photo: user['response']['photo'] ?? '',
      accessToken: user['response']['access_token'] ?? '',
    );
    return userModel;
  }
}
