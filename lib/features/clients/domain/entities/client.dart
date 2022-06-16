import 'package:equatable/equatable.dart';

class ClientData extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  
  const ClientData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
  
  @override
  List<Object?> get props => [id];
}
