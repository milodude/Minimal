import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:coda_test/features/clients/domain/entities/client.dart';

import '../../../domain/use_cases/add_client_use_case.dart';

part 'single_client_event.dart';
part 'single_client_state.dart';

class SingleClientBloc extends Bloc<SingleClientEvent, SingleClientState> {
  AddClientUseCase addClientUseCase;
  SingleClientBloc(
    {required this.addClientUseCase}
  ) : super(SingleClientInitial()) {
    on<SingleClientEvent>((event, emit) async {
      if(event is AddSingleClient){
        emit(SingleClientSaving());
        final result = await addClientUseCase(ClientParams(client: event.clientToAdd));
        result.fold(
          (left) => emit(SingleClientError(errorMessage: left.toString())),
          (right) {
            emit(SingleClientSaved(savedClient: right));
          },
        );
      }
    });
  }
}
