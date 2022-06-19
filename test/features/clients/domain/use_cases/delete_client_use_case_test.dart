import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/features/clients/domain/repository/client_repository.dart';
import 'package:coda_test/features/clients/domain/use_cases/delete_client_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_client_use_case_test.mocks.dart';

@GenerateMocks([ClientRepository], customMocks: [
  MockSpec<ClientRepository>(as: #MockClientRepositoryVoid, returnNullOnMissingStub: true),
])
void main() {
  MockClientRepository mockClientRepositoryVoid = MockClientRepository();
  DeleteClientUseCase deleteClientUseCase = DeleteClientUseCase(clientRepository: mockClientRepositoryVoid);
  const int clientId=7;
  testWidgets('delete client use case ...', (tester) async {
    when(mockClientRepositoryVoid.deleteClient(clientId)).thenAnswer((realInvocation) => Future.value(const Right(null)));
    deleteClientUseCase.call(clientId);
    verify(mockClientRepositoryVoid.deleteClient(clientId)).called(1);
  });

  testWidgets('Should throw a Failure', (tester) async {
      //ARRANGE
      const errorMessage = 'Some error';
      when(mockClientRepositoryVoid.deleteClient(clientId))
          .thenAnswer(((realInvocation) {
        return Future.value(Left(ServerFailure(errorMessage)));
      }));
      //ACT
      var result = await deleteClientUseCase(clientId);
      //ASSERT
      expect(result, Left(ServerFailure(errorMessage)));
      verify(mockClientRepositoryVoid.deleteClient(clientId)).called(1);
    });
}