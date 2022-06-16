import 'dart:convert';
import 'package:coda_test/features/clients/data/model/client_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('Client model tests: ', () {
    var tUser = const ClientModel(
      id: 816,
      firstName: 'Franco',
      lastName: 'Camiletti',
      email: 'matias@agencycoda.com',
    );

    testWidgets('Should be a client model', (tester) async {
      expect(tUser, isA<ClientModel>());
    });
    
    testWidgets('Should parse a client from a json response', (tester) async {
       //Arrange
      final Map<String, dynamic> decoded =
          json.decode(fixture('clients/client.json'));
      //Act
      var result = ClientModel.fromJson(decoded);
      //Assert
      expect(result, equals(tUser));
    });
  });
}
