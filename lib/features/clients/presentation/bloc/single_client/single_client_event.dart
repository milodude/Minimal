part of 'single_client_bloc.dart';

abstract class SingleClientEvent extends Equatable {
  const SingleClientEvent();

  @override
  List<Object> get props => [];
}

class AddSingleClient extends SingleClientEvent{
  final ClientData clientToAdd;

 const AddSingleClient({required this.clientToAdd});
}
