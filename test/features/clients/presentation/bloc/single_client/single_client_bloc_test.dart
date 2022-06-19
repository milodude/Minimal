import 'package:bloc_test/bloc_test.dart';
import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/features/clients/domain/entities/client.dart';
import 'package:coda_test/features/clients/domain/use_cases/add_client_use_case.dart';
import 'package:coda_test/features/clients/presentation/bloc/single_client/single_client_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'single_client_bloc_test.mocks.dart';

@GenerateMocks([AddClientUseCase])
void main() {
  MockAddClientUseCase mockAddClientsUseCase = MockAddClientUseCase();
  late SingleClientBloc bloc =
      SingleClientBloc(addClientUseCase: mockAddClientsUseCase);

  ClientData tClientData = const ClientData(
      id: 70,
      firstName: 'firstName',
      lastName: 'lastName',
      email: 'email',
      caption: '');

  group('Client BLOC: ', () {
    setUp(() {
      bloc.close();
      bloc = SingleClientBloc(addClientUseCase: mockAddClientsUseCase);
    });

    blocTest('emits [] when nothing is added',
        build: () => bloc,
        expect: () => [],
        wait: const Duration(milliseconds: 500));

    blocTest<SingleClientBloc, SingleClientState>(
        'emits [Loading, Error] when getting my watchlists fails.',
        setUp: () => when(mockAddClientsUseCase.call(ClientParams(client: tClientData))).thenAnswer(
            (realInvocation) async =>
                Future.value(Left(ServerFailure(serverException)))),
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(AddSingleClient(clientToAdd: tClientData)),
        expect: () => <SingleClientState>[
              SingleClientSaving(),
              SingleClientError(errorMessage: serverException)
            ],
        wait: const Duration(milliseconds: 500));
  });
}
