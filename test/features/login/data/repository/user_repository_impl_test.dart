import 'dart:convert';

import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/features/login/data/data_source/user_data_source.dart';
import 'package:coda_test/features/login/data/model/user_model.dart';
import 'package:coda_test/features/login/data/repository/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([UserDataSource])
void main() {
  MockUserDataSource mockUserDataSource = MockUserDataSource();
  UserRepositoryDataSourceImpl userRepositoryImpl =
      UserRepositoryDataSourceImpl(userDataSource: mockUserDataSource);
  const String userName = 'Matt';
  const String password = '123456';

  group('User Repository implementation tests: ', () {
    testWidgets('Should login a user properly', (tester) async {
      //ARRANGE
      final tUserModel =
          UserModel.fromJson(json.decode(fixture('login/user_data.json')));
      when(mockUserDataSource.login(userName: userName, password: password))
          .thenAnswer((realInvocation) async => Future.value(tUserModel));
      //ACT
      var result = await userRepositoryImpl.login(
          userName: userName, password: password);
      //ASSERT
      verify(mockUserDataSource.login(userName: userName, password: password));
      expect(true, result.isRight());
      result.fold((left) => fail('test failed'), (right) {
        expect(right, equals(tUserModel));
      });
    });

    testWidgets('Should login a user but gets a failure', (tester) async {
      //ARRANGE
      when(mockUserDataSource.login(userName: userName, password: password))
          .thenThrow((realInvocation) async => Future.value(ServerFailure('Error Message')));
      //ACT
      var result = await userRepositoryImpl.login(
          userName: userName, password: password);
      //ASSERT
      verify(mockUserDataSource.login(userName: userName, password: password));
      expect(true, result.isLeft());
    });
  });
}
