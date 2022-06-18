import 'package:coda_test/features/clients/domain/entities/client.dart';

class ClientModel extends ClientData {
  const ClientModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.caption,
  });

  factory ClientModel.fromJson(Map<String, dynamic> client) {

    return ClientModel(
      id: client['id'],
      firstName: client['firstname'],
      lastName: client['lastname'],
      email: client['email'],
      caption: client['caption'],
    );
  }

  
}
