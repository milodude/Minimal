import 'package:bloc_test/bloc_test.dart';
import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/core/use_cases/use_case.dart';
import 'package:coda_test/features/clients/domain/entities/client.dart';
import 'package:coda_test/features/clients/domain/use_cases/get_clients_use_case.dart';
import 'package:coda_test/features/clients/presentation/bloc/client/client_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'client_bloc_test.mocks.dart';

@GenerateMocks([GetClientsUseCase, ShowMoreInClientsList])
void main() {
  MockGetClientsUseCase mockGetClientsUseCase = MockGetClientsUseCase();
  late ClientBloc bloc = ClientBloc(getClientsUseCase: mockGetClientsUseCase);

  List<ClientData> tClientData = <ClientData>[
    const ClientData(
        id: 70, firstName: 'firstName', lastName: 'lastName', email: 'email',caption: ''),
    const ClientData(
        id: 1, firstName: 'firstName1', lastName: 'lastName1', email: 'email', caption: ''),
    const ClientData(
        id: 2, firstName: 'firstName2', lastName: 'lastName2', email: 'email', caption: ''),
    const ClientData(
        id: 3, firstName: 'firstName3', lastName: 'lastName3', email: 'email', caption: ''),
    const ClientData(
        id: 4, firstName: 'firstName4', lastName: 'lastName4', email: 'email', caption: ''),
    const ClientData(
        id: 5, firstName: 'firstName5', lastName: 'lastName5', email: 'email', caption: ''),
    const ClientData(
        id: 6, firstName: 'firstName6', lastName: 'lastName6', email: 'email', caption: ''),
    const ClientData(
        id: 7, firstName: 'firstName7', lastName: 'lastName7', email: 'email', caption: ''),
  ];
  group('Client BLOC: ', () {
    setUp(() {
      bloc.close();
      bloc = ClientBloc(getClientsUseCase: mockGetClientsUseCase);
    });

    blocTest('emits [] when nothing is added',
        build: () => bloc,
        expect: () => [],
        wait: const Duration(milliseconds: 500));

    blocTest<ClientBloc, ClientState>(
        'emits [Loading, Error] when getting my watchlists fails.',
        setUp: () => when(mockGetClientsUseCase.call(NoParams())).thenAnswer(
            (realInvocation) async =>
                Future.value(Left(ServerFailure(serverException)))),
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(const GetClients()),
        expect: () =>
            <ClientState>[Loading(), Error(errorMessage: serverException)],
        wait: const Duration(milliseconds: 500));

    blocTest<ClientBloc, ClientState>(
        'should add values in an ordered manner each time it shows more clients.',
        setUp: () => when(mockGetClientsUseCase.call(NoParams())).thenAnswer(
            (realInvocation) async => Future.value(Right(tClientData))),
        build: () {
          return bloc;
        },
        act: (bloc) {
          bloc.add(const GetClients());
          bloc.add(ShowMoreInClientsList(
              clientsList: bloc.state.clientsData,
              clientsToShowList: bloc.state.clientDataToShow));
        },
        expect: () => <ClientState>[
              Loading(),
              Loaded(bloc.state.clientsData,
                  bloc.state.clientsData.take(5).toList()),
              Loaded(bloc.state.clientsData, bloc.state.clientsData),  
            ],
        tearDown: bloc.close,
        wait: const Duration(milliseconds: 500));
  });
}
