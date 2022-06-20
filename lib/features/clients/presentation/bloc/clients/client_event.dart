part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent(
  );

  @override
  List<Object> get props => [];
}
//revisar lo que le paso a la clase base de clients..
class GetClients extends ClientEvent{
    const GetClients() : super();
}

class ShowMoreInClientsList extends ClientEvent{
  final List<ClientData> clientsList;
  final List<ClientData> clientsToShowList;

  const ShowMoreInClientsList({required this.clientsList,required this.clientsToShowList}) : super();

}

class AddClient extends ClientEvent {
  final ClientData clientToAdd;
  const AddClient({
    required this.clientToAdd,
  });
}

class DeleteClient extends ClientEvent {
  final int clientId;
  const DeleteClient({
    required this.clientId,
  });
}


class EditClient extends ClientEvent {
  final ClientData clientToEdit;
  const EditClient({
    required this.clientToEdit,
  });
}