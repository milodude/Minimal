import 'dart:convert';
import 'package:coda_test/features/clients/data/model/client_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('Client model tests: ', () {
    var tClient = const ClientModel(
      id: 816,
      firstName: 'Franco',
      lastName: 'Camiletti',
      email: 'matias@agencycoda.com',
      caption: ''
    );

    testWidgets('Should be a client model', (tester) async {
      expect(tClient, isA<ClientModel>());
    });
    
    testWidgets('Should parse a client from a json response', (tester) async {
       //Arrange
      final Map<String, dynamic> decoded =
          json.decode(fixture('clients/client.json'));
      //Act
      var result = ClientModel.fromJson(decoded);
      //Assert
      expect(result, equals(tClient));
    });

     testWidgets('Should parse all client fields from a json response', (tester) async {
       //Arrange
      final Map<String, dynamic> decoded =
          json.decode(fixture('clients/client.json'));
      //Act
      var result = ClientModel.fromJson(decoded);
      //Assert
      expect(result.id, equals(tClient.id));
      expect(result.email, equals(tClient.email));
      expect(result.firstName, equals(tClient.firstName));
      expect(result.lastName, equals(tClient.lastName));
      expect(result.caption, equals(tClient.caption));
    });
  });
}
