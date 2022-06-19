import 'package:equatable/equatable.dart';

class ClientData extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? caption;
  final String? photo;
  
  const ClientData({
    required this.firstName,
    required this.lastName,
    required this.email,
     this.id = 0,
     this.caption,
     this.photo
  });
  
  @override
  List<Object?> get props => [id, firstName, lastName, email];
}
