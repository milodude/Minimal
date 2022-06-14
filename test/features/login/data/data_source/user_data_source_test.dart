import 'dart:convert';

import 'package:coda_test/core/constants/access.dart';
import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/core/provider/url_provider.dart';
import 'package:coda_test/features/login/data/data_source/user_data_source.dart';
import 'package:coda_test/features/login/data/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'user_data_source_test.mocks.dart';

@GenerateMocks([http.Client, UrlProvider])
void main() {
  MockClient mockHttpClient = MockClient();
  MockUrlProvider mockUrlProvider = MockUrlProvider();

  UserDataSource userDataSource =
      UserDataSource(httpClient: mockHttpClient, urlProvider: mockUrlProvider);
  
  final tUserModel =
      UserModel.fromJson(json.decode(fixture('login/user_data.json')));

  void setUpHttpCallSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => Future.value(
            http.Response(fixture('login/user_data.json'), 200)));
      final uri =
          Uri.https(serverUrl, '/mia-auth/login', null);
      when(mockUrlProvider.getUrl(any, any)).thenAnswer((realInvocation) => uri);
  }

  group('Http configuration: ', () {
    testWidgets(
        'should perform a get request for a watchlist with application/json header',
        (tester) async {
      //Arrange
      setUpHttpCallSuccess200();
    
      //Act
      await userDataSource.login(password: 'Matt', userName: '123456');
      //Assert
      verify(mockHttpClient.get(any, headers: {
        'Content-type': 'application/json',
        'Accept': 'text/plain',
        'Access-Control-Allow-Origin': '*'
      }));
    });
  });

  group('User data source tests: ', () {
    testWidgets('Should send a logging request without any issues', (tester) async {
      //Arrange
      setUpHttpCallSuccess200();
      //Act
      var result = await userDataSource.login(password: 'Matt', userName: '123456');
      //Assert
      expect(result, equals(tUserModel));
    });

     test('Should throw a serverException when the respond is 404 or other',
        () async {
      //Arrange
      final uri =
          Uri.https(serverUrl, '/mia-auth/login', null);
      when(mockUrlProvider.getUrl(any, any)).thenAnswer((realInvocation) => uri);
      
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (realInvocation) async => http.Response(
            'Something went wrong while logging in',
            404),
      );
      //Act
      final call = userDataSource.login(password: 'Matt', userName: '123456');
      //Assert
      expect(() => call, throwsA(const TypeMatcher<ServerFailure>()));
    });
  });

  
}
