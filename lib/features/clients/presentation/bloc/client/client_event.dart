part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
   final List<ClientData>? clients;
  final List<ClientData>? clientsToShow;
  const ClientEvent(
     this.clients,
     this.clientsToShow
  );

  @override
  List<Object> get props => [];
}
//revisar lo que le paso a la clase base de clients..
class GetClients extends ClientEvent{
    const GetClients() : super(null, null);
}

class ShowMoreInClientsList extends ClientEvent{
  final List<ClientData> clientsList;
  final List<ClientData> clientsToShowList;

  const ShowMoreInClientsList({required this.clientsList,required this.clientsToShowList}) : super(clientsList, clientsToShowList);

}
