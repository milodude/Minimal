import 'package:bloc/bloc.dart';
import 'package:coda_test/core/use_cases/use_case.dart';
import 'package:equatable/equatable.dart';

import 'package:coda_test/features/clients/domain/entities/client.dart';
import '../../../domain/use_cases/get_clients_use_case.dart' as use_case;
part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final use_case.GetClientsUseCase getClientsUseCase;

  ClientBloc({required this.getClientsUseCase}) : super(Initial()) {
    on<ClientEvent>((event, emit) async {
      if (event is GetClients) {
        emit(Loading());
        final result = await getClientsUseCase(NoParams());
        result.fold(
          (left) => emit(Error(errorMessage: left.toString())),
          (right) {
            right.sort((a, b) => a.id.compareTo(b.id));
            emit(Loaded(right, right.take(5).toList()));
          },
        );
      }
      if (event is ShowMoreInClientsList) {
        List<ClientData> filteredLst =
            List.from(state.clientsData.where((value) => !state.clientDataToShow.contains(value)));
        filteredLst.sort(((a, b) => a.id.compareTo(b.id)));
        var addedValues =  state.clientDataToShow + filteredLst.take(5).toList();
        emit(Loaded(state.clientsData, addedValues));
      }
    });
  }
}
