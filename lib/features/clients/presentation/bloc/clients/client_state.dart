part of 'client_bloc.dart';

class ClientState extends Equatable {
  final List<ClientData> clientsData;
  final List<ClientData> clientDataToShow;

  const ClientState(this.clientsData, this.clientDataToShow);
  
  @override
  List<Object> get props => [clientsData, clientDataToShow];

  ClientState copyWith({
    required List<ClientData>? clientsData,
    required List<ClientData>? clientDataToShow,
  }){
    return ClientState(
      clientsData?? this.clientsData,
       clientDataToShow ?? this.clientDataToShow,
    );
  }
}

class Initial extends ClientState {

  Initial(
  ) : super(List.empty(), List.empty());
}

class Loading extends ClientState {
  
  Loading():super(List.empty(), List.empty());
}

class Loaded extends ClientState {
  final List<ClientData> clients;
  final List<ClientData> clientsToShow;
  
  const Loaded(this.clients, this.clientsToShow):super(clients, clientsToShow);
  @override
  List<Object> get props => [clients, clientsToShow];
}

class AddClientsToShow extends ClientState {
  final List<ClientData> clients;
  final List<ClientData> clientsToShow;
  
  const AddClientsToShow(this.clients, this.clientsToShow):super(clients, clientsToShow);
}

class Saved extends ClientState{
  final List<ClientData> clients;
  final List<ClientData> clientsToShow;

  const Saved(this.clients, this.clientsToShow):super(clients, clientsToShow);
}

class Error extends ClientState{
   final String errorMessage;

  Error({required this.errorMessage}) : super(List.empty(), List.empty());
}
