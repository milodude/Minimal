part of 'single_client_bloc.dart';

abstract class SingleClientState extends Equatable {
  final ClientData clientData;
  
  const SingleClientState(
    this.clientData,
  );

  @override
  List<Object> get props => [];
}

class SingleClientInitial extends SingleClientState {
  SingleClientInitial():super(emptyClient());

}
class SingleClientSaving extends SingleClientState {
  SingleClientSaving():super(emptyClient());
}
class SingleClientSaved extends SingleClientState {
  final ClientData savedClient;
  const SingleClientSaved(
    {required this.savedClient}
  ):super(savedClient);
}
class SingleClientError extends SingleClientState {
  final String errorMessage;
  SingleClientError(
    {required this.errorMessage}
  ):super(emptyClient());
}

ClientData emptyClient() => const ClientData(id: 0, firstName: '', lastName: '', email: '', caption: '');
