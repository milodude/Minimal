
import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/features/clients/domain/entities/client.dart';
import 'package:coda_test/features/clients/domain/repository/client_repository.dart';
import 'package:coda_test/features/clients/domain/use_cases/edit_client_use_case.dart';
import 'package:coda_test/features/clients/domain/use_cases/params/client_params.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_client_use_case_test.mocks.dart';

@GenerateMocks([ClientRepository])
void main() {
  MockClientRepository mockClientRepository = MockClientRepository();
  EditClientUseCase useCase =
      EditClientUseCase(clientRepository: mockClientRepository);
  ClientData tClient = const ClientData(
    id: 7,
    firstName: 'Matt',
    lastName: 'Raverta',
    email: 'some@email.com',
    caption: ''
  );

  group('EditClient UseCase: ', () {
    testWidgets('Should edit a client', (tester) async {
      //ARRANGE

      when(mockClientRepository.editClient(tClient))
          .thenAnswer(((realInvocation) => Future.value(Right(tClient))));
      //ACT
      var result = await useCase(ClientParams(client: tClient));
      //ASSERT
      expect(result, Right(tClient));
      verify(mockClientRepository.editClient(tClient)).called(1);
    });

    testWidgets('Should throw a Failure', (tester) async {
      //ARRANGE
      const errorMessage = 'Some error';
      when(mockClientRepository.editClient(tClient))
          .thenAnswer(((realInvocation) {
        return Future.value(Left(ServerFailure(errorMessage)));
      }));
      //ACT
      var result = await useCase(ClientParams(client: tClient));
      //ASSERT
      expect(result, Left(ServerFailure(errorMessage)));
      verify(mockClientRepository.editClient(tClient)).called(1);
    });
  });
}
