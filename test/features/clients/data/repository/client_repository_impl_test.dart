import 'dart:convert';

import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/features/clients/data/data_source/client_data_source.dart';
import 'package:coda_test/features/clients/data/model/client_model.dart';
import 'package:coda_test/features/clients/data/repository/client_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'client_repository_impl_test.mocks.dart';

@GenerateMocks([ClientDataSource])
void main() {
  MockClientDataSource mockClientDataSource = MockClientDataSource();
  ClientRepositoryImpl clientRepositoryImpl =
      ClientRepositoryImpl(clientDataSource: mockClientDataSource);
  final tClientListResponse = json.decode(fixture('clients/client_list.json'));

  List<ClientModel> _getList() {
    List<ClientModel> clientList = <ClientModel>[];
    List<dynamic> responseList = tClientListResponse['response']['data'];
    for (Map<String, dynamic> item in responseList) {
      var client = ClientModel.fromJson(item);
      clientList.add(client);
    }
    return clientList;
  }

  group('Client repository impl tests: ', () {
    testWidgets('Should  get a list of clients', (tester) async {
      //ARRANGE
      final tClientListModel = _getList();
      when(mockClientDataSource.getClients())
          .thenAnswer((realInvocation) async => Future.value(tClientListModel));
      //ACT
      var result = await clientRepositoryImpl.getClientList();
      //ASSERT
      verify(mockClientDataSource.getClients());
      expect(true, result.isRight());
      result.fold((left) => fail('test failed'), (right) {
        expect(right, equals(tClientListModel));
      });
    });

    testWidgets('Should get a list of clients but gets a failure',
        (tester) async {
      //ARRANGE
      when(mockClientDataSource.getClients()).thenThrow(
          (realInvocation) async =>
              Future.value(ServerFailure('Error Message')));
      //ACT
      var result = await clientRepositoryImpl.getClientList();
      //ASSERT
      verify(mockClientDataSource.getClients());
      expect(true, result.isLeft());
    });

    testWidgets('Should add a client', (tester) async {
      //ARRANGE
      final tClient = _getList().first;
      when(mockClientDataSource.addClient(tClient))
          .thenAnswer((realInvocation) async => Future.value(tClient));
      //ACT
      var result = await clientRepositoryImpl.addClient(tClient);
      //ASSERT
      verify(mockClientDataSource.addClient(tClient));
      expect(true, result.isRight());
      result.fold((left) => fail('test failed'), (right) {
        expect(right, equals(tClient));
      });
    });
  });
}
