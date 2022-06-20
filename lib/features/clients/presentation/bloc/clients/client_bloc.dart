import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:coda_test/core/use_cases/use_case.dart';
import 'package:coda_test/features/clients/domain/entities/client.dart';
import 'package:coda_test/features/clients/domain/use_cases/add_client_use_case.dart';

import '../../../domain/use_cases/get_clients_use_case.dart' as use_case;

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final use_case.GetClientsUseCase getClientsUseCase;
  final AddClientUseCase addClientUseCase;
  
  ClientBloc({
    required this.getClientsUseCase,
    required this.addClientUseCase,
  }) : super(Initial()) {
    on<ClientEvent>((event, emit) async {
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
      if (event is ShowMoreInClientsList) {
        List<ClientData> filteredLst =
            List.from(state.clientsData.where((value) => !state.clientDataToShow.contains(value)));
        filteredLst.sort(((a, b) => b.id.compareTo(a.id)));
        var addedValues =[state.clientDataToShow, filteredLst.take(5)].expand((x) => x).toList();
        emit(Loaded(state.clientsData, addedValues));
      }

      if (event is AddClient) {
        emit(Loading());
        final result = await addClientUseCase(ClientParams(client: event.clientToAdd));
        emit(Saved(state.clientsData, state.clientDataToShow));
      }
    });
  }
}
