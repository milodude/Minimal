import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/core/use_cases/use_case.dart';
import 'package:coda_test/features/clients/domain/entities/client.dart';
import 'package:coda_test/features/clients/domain/repository/client_repository.dart';
import 'package:coda_test/features/clients/domain/use_cases/get_clients_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_clients_use_case_test.mocks.dart';


@GenerateMocks([ClientRepository])
void main() {
 MockClientRepository mockClientRepository = MockClientRepository();
  GetClientsUseCase useCase =
      GetClientsUseCase(clientRepository: mockClientRepository);

  group('GetClients UseCase: ', () {
    testWidgets('Should get a list of clients', (tester) async {
      //ARRANGE
      var tClientList = <ClientData>[
        const ClientData(id: 7, firstName: 'Matt', lastName: 'Raverta', email: 'some@email.com', caption: '')
      ];
      when(mockClientRepository.getClientList())
          .thenAnswer(((realInvocation) => Future.value(Right(tClientList))));
      //ACT
      var result = await useCase(NoParams());
      //ASSERT
      expect(result, Right(tClientList));
      verify(mockClientRepository.getClientList()).called(1);
    });

    testWidgets('Should throw a Failure', (tester) async {
      //ARRANGE
      const errorMessage = 'Some error';
      when(mockClientRepository.getClientList())
          .thenAnswer(((realInvocation) {
        return Future.value(Left(ServerFailure(errorMessage)));
      }));
      //ACT
      var result = await useCase(NoParams());
      //ASSERT
      expect(result, Left(ServerFailure(errorMessage)));
      verify(mockClientRepository.getClientList()).called(1);
    });
  });
}
