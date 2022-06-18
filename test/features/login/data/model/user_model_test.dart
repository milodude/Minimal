import 'dart:convert';
import 'package:coda_test/features/login/data/model/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('User model tests: ', () {
    var tUser = const UserModel(
      id: 1,
      firstName: 'empty',
      lastName: '',
      email: 'test@coda.com',
      photo: '',
      accessToken:
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYWdlbmN5Y29kYS5jb20iLCJhdWQiOiJodHRwczpcL1wvYWdlbmN5Y29kYS5jb20iLCJpYXQiOjE2NTUyMTYyMjksIm5iZiI6MTY1NTIxNjIyOSwiZXhwIjoxNjU2NTEyMjI5LCJ1aWQiOjEsImRhdGEiOnsiaWQiOjEsImVtYWlsIjoidGVzdEBjb2RhLmNvbSJ9fQ.CIhOM7phABV-p9EJIskmvOM0FbLDCgYzZF5Jzeqh3qk',
    );

    testWidgets('Should be a user model', (tester) async {
      expect(tUser, isA<UserModel>());
    });
    
    testWidgets('Should parse a user from a json response', (tester) async {
       //Arrange
      final Map<String, dynamic> decoded =
          json.decode(fixture('login/user_data.json'));
      //Act
      var result = UserModel.fromJson(decoded);
      //Assert
      expect(result, equals(tUser));
    });

     testWidgets('Should parse all user fields from a json response', (tester) async {
       //Arrange
      final Map<String, dynamic> decoded =
          json.decode(fixture('login/user_data.json'));
      //Act
      var result = UserModel.fromJson(decoded);
      //Assert
      expect(result.accessToken, equals(tUser.accessToken));
      expect(result.email, equals(tUser.email));
      expect(result.firstName, equals(tUser.firstName));
      expect(result.lastName, equals(tUser.lastName));
      expect(result.photo, equals(tUser.photo));
    });
  });
}
