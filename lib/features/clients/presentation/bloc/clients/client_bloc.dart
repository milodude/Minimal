import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:coda_test/core/use_cases/use_case.dart';
import 'package:coda_test/features/clients/domain/entities/client.dart';
import 'package:coda_test/features/clients/domain/use_cases/add_client_use_case.dart';

import '../../../domain/use_cases/delete_client_use_case.dart';
import '../../../domain/use_cases/edit_client_use_case.dart';
import '../../../domain/use_cases/get_clients_use_case.dart' as use_case;
import '../../../domain/use_cases/params/client_params.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final use_case.GetClientsUseCase getClientsUseCase;
  final AddClientUseCase addClientUseCase;
  final DeleteClientUseCase deleteClientUseCase;
  final EditClientUseCase editClientUseCase;

  ClientBloc({
    required this.getClientsUseCase,
    required this.addClientUseCase,
    required this.deleteClientUseCase,
    required this.editClientUseCase,
  }) : super(Initial()) {
    on<ClientEvent>((event, emit) async {
      //!GET clients list
      if (event is GetClients) {
        emit(Loading());
        final result = await getClientsUseCase(NoParams());
        result.fold(
          (left) => emit(Error(errorMessage: left.toString())),
          (right) {
            right.sort((a, b) => b.id.compareTo(a.id));
            emit(Loaded(right, right.take(5).toList()));
          },
        );
      }

      //!SHOW more clients
      if (event is ShowMoreInClientsList) {
        List<ClientData> filteredLst = List.from(state.clientsData
            .where((value) => !state.clientDataToShow.contains(value)));
        filteredLst.sort(((a, b) => b.id.compareTo(a.id)));
        var addedValues = [state.clientDataToShow, filteredLst.take(5)]
            .expand((x) => x)
            .toList();
        emit(Loaded(state.clientsData, addedValues));
      }

      //!ADD a client
      if (event is AddClient) {
        List<ClientData> updatedList = <ClientData>[];
        emit(Loading());
        final result =
            await addClientUseCase(ClientParams(client: event.clientToAdd));
        var newList = await getClientsUseCase(NoParams());
         newList.fold(
          (left) => emit(Error(errorMessage: left.toString())),
          (right) {
            updatedList = right;
            right.sort((a, b) => b.id.compareTo(a.id));
            emit(Loaded(right, right.take(5).toList()));
          },
        );

        result.fold(
          (left) => emit(Error(errorMessage: left.toString())),
          (right) {
            updatedList.sort((a, b) => b.id.compareTo(a.id));
            var newState = state.copyWith(clientsData: updatedList,clientDataToShow: updatedList.take(5).toList());
            emit(Saved(newState.clientsData, newState.clientDataToShow));
          },
        );
      }
      //!DELETE a client
      if (event is DeleteClient) {
        emit(Loading());
        final result = await deleteClientUseCase(event.clientId);

        result.fold(
          (left) => emit(Error(errorMessage: left.toString())),
          (right) {
             List<ClientData> listWithoutDeleted = List.from(state.clientDataToShow
            .where((value) => value.id != event.clientId));
            emit(Saved(state.clientsData, listWithoutDeleted));
          },
        );
      }
      //!EDIT a client
      if (event is EditClient) {
        emit(Loading());
        final result = await editClientUseCase(ClientParams(client: event.clientToEdit));

        result.fold(
          (left) => emit(Error(errorMessage: left.toString())),
          (right) {
            emit(Saved(state.clientsData, state.clientDataToShow));
          },
        );
      }

      if (event is SearchClient) {
        var filteredList = state.clientsData.where((element) => element.firstName == event.name).toList();
        filteredList.sort((a, b) => a.firstName.compareTo(event.name));
        emit(Loaded(state.clientsData, filteredList.take(5).toList()));
      }

    });
  }
}
