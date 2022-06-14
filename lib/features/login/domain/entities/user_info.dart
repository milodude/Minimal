import 'package:equatable/equatable.dart';

class UserInfo extends Equatable{
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String photo;
  final String accessToken;
  
  const UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.photo,
    required this.accessToken,
  });
  
  @override
  List<Object?> get props => [id, email];
}
