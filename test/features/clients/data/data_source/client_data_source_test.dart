import 'dart:convert';

import 'package:coda_test/core/constants/access.dart';
import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/core/provider/url_provider.dart';
import 'package:coda_test/features/clients/data/data_source/client_data_source.dart';
import 'package:coda_test/features/clients/data/model/client_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'client_data_source_test.mocks.dart';

@GenerateMocks([http.Client, UrlProvider])
void main() {
  MockUrlProvider mockUrlProvider = MockUrlProvider();
  MockClient mockClient = MockClient();
  ClientDataSource clientDataSource =
      ClientDataSource(httpClient: mockClient, urlProvider: mockUrlProvider);
  final tClientListResponse = json.decode(fixture('clients/client_list.json'));
  ClientModel tClient = const ClientModel(
      id: 946,
      firstName: 'Matias',
      lastName: 'Raven',
      email: 'matiasRaven@agencycoda.com',
      caption: '70');

  List<ClientModel> _getList() {
    List<ClientModel> clientList = <ClientModel>[];
    List<dynamic> responseList = tClientListResponse['response']['data'];
    for (Map<String, dynamic> item in responseList) {
      var client = ClientModel.fromJson(item);
      clientList.add(client);
    }
    return clientList;
  }

  void setUpHttpCallSuccess200() {
    final uri = UrlProvider().getUrl('/client/list', {});
    when(mockClient.post(uri, body: json.encode({}), headers: {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*',
    })).thenAnswer((_) async =>
        Future.value(http.Response(fixture('clients/client_list.json'), 200)));
    when(mockUrlProvider.getUrl(any, any)).thenAnswer((realInvocation) => uri);
  }

  testWidgets('client data source ...', (tester) async {
    //Arrange
    setUpHttpCallSuccess200();
  });

  group('Http configuration: ', () {
    testWidgets(
        'should perform a get request for a watchlist with application/json header',
        (tester) async {
      //Arrange
      setUpHttpCallSuccess200();

      //Act
      await clientDataSource.getClients();
      //Assert
      verify(mockClient.post(any, body: json.encode({}), headers: {
        'Content-type': 'application/json',
        'Accept': '*/*',
        'Access-Control-Allow-Origin': '*',
      }));
    });
  });

  group('Client data source tests: ', () {
    testWidgets('Should send a request for clients without any issues',
        (tester) async {
      //Arrange
      setUpHttpCallSuccess200();
      //Act
      var result = await clientDataSource.getClients();
      //Assert
      expect(result, equals(_getList()));
    });

    test('Should throw a serverException when the respond is 404 or other when getting a list of clients',
        () async {
      //Arrange
      final uri = Uri.https(serverUrl, '/client/list', null);
      when(mockUrlProvider.getUrl(any, any))
          .thenAnswer((realInvocation) => uri);

      when(mockClient.post(uri,
              body: json.encode({}), headers: anyNamed('headers')))
          .thenAnswer(
        (realInvocation) async =>
            http.Response('Something went wrong while getting clients', 404),
      );
      //Act
      final call = clientDataSource.getClients();
      //Assert
      expect(() => call, throwsA(const TypeMatcher<ServerFailure>()));
    });

    test('Should save a new client', () async {
      //Arrange
      final uri = Uri.https(serverUrl, '/client/save', null);
      when(mockUrlProvider.getUrl(any, any))
          .thenAnswer((realInvocation) => uri);

      when(mockClient.post(uri,
              body: json.encode(tClient.addClientToJson()),
              headers: anyNamed('headers')))
          .thenAnswer(
        (realInvocation) async => Future.value(
            http.Response(fixture('clients/client_response.json'), 200)),
      );
      //Act
      final result = await clientDataSource.addClient(tClient);
      //Assert
      expect(result, equals(tClient));
    });

    test('Should throw a serverException when the respond is 404 or other  when adding',
        () async {
      //Arrange
      final uri = Uri.https(serverUrl, '/client/save', null);
      when(mockUrlProvider.getUrl(any, any))
          .thenAnswer((realInvocation) => uri);

      when(mockClient.post(uri,
              body: json.encode(tClient.addClientToJson()),
              headers: anyNamed('headers')))
          .thenAnswer(
        (realInvocation) async =>
            http.Response('Something went wrong while saving the client', 404),
      );
      //Act
      final call = clientDataSource.addClient(tClient);
      //Assert
      expect(() => call, throwsA(const TypeMatcher<ServerFailure>()));
    });

    test('Should delete a client', () async {
      //Arrange
      int clientId = 70;
      final uri = Uri.https(serverUrl, '/client/remove/$clientId', {});
      when(mockUrlProvider.getUrl(any, any))
          .thenAnswer((realInvocation) => uri);

      when(mockClient.delete(uri,body: json.encode({}), headers: anyNamed('headers'))).thenAnswer(
        (realInvocation) async => Future.value(
            http.Response(fixture('clients/delete_response.json'), 200)),
      );
      //Act
      await clientDataSource.deleteClient(clientId);
      //Assert
      verify(mockClient.delete(uri,body: json.encode({}), headers: {
        'Content-type': 'application/json',
        'Accept': '*/*',
        'Access-Control-Allow-Origin': '*',
      })).called(1);
    });

    test('Should throw a serverException when the respond is 404 or other when removing',
        () async {
      //Arrange
      int clientId = 70;
      final uri = Uri.https(serverUrl, '/client/remove/$clientId', {});
      when(mockUrlProvider.getUrl(any, any))
          .thenAnswer((realInvocation) => uri);

      when(mockClient.delete(uri, body: json.encode({}),headers: anyNamed('headers'))).thenAnswer(
        (realInvocation) async => http.Response('Something went wrong while saving the client', 404),
      );
      //Act
      //Assert
      expect(() => clientDataSource.deleteClient(clientId), throwsA(const TypeMatcher<ServerFailure>()));
    });

    test('Should edit a client', () async {
      //Arrange
      final uri = Uri.https(serverUrl, '/client/save', null);
      when(mockUrlProvider.getUrl(any, any))
          .thenAnswer((realInvocation) => uri);

      when(mockClient.post(uri,
              body: json.encode(tClient.toJson()),
              headers: anyNamed('headers')))
          .thenAnswer(
        (realInvocation) async => Future.value(
            http.Response(fixture('clients/client_response.json'), 200)),
      );
      //Act
      final result = await clientDataSource.editClient(tClient);
      //Assert
      expect(result, equals(tClient));
    });

    test('Should throw a serverException when the respond is 404 or other when editing',
        () async {
      //Arrange
      final uri = Uri.https(serverUrl, '/client/save', {});
      when(mockUrlProvider.getUrl(any, any))
          .thenAnswer((realInvocation) => uri);

      when(mockClient.post(uri, body: json.encode(tClient.toJson()),headers: anyNamed('headers'))).thenAnswer(
        (realInvocation) async => http.Response('Something went wrong while saving the client', 404),
      );
      //Act
      //Assert
      expect(() => clientDataSource.editClient(tClient), throwsA(const TypeMatcher<ServerFailure>()));
    });
  });
}
