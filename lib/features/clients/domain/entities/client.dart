import 'package:equatable/equatable.dart';

class ClientData extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String caption;
  
  const ClientData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.caption
  });
  
  @override
  List<Object?> get props => [id, firstName,  lastName, email];
}
