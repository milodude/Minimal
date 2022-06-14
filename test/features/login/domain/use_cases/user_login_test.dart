import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/features/login/domain/entities/user_info.dart';
import 'package:coda_test/features/login/domain/repository/user_repository.dart';
import 'package:coda_test/features/login/domain/use_cases/user_login.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_login_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  MockUserRepository mockUserRepository = MockUserRepository();
  UserLogin useCase = UserLogin(userRepository: mockUserRepository);
  String userName = 'Matt';
  String password = '123456';

  group('Login user Use Case tests: ', () {
    testWidgets('Should login a user successfully and retrieve user data', (tester) async {
      //ARRANGE
      var tUserInfo = const UserInfo(id: 1, firstName: 'Matt', lastName: 'Raverta', email: '@gmail.com', photo: 'someUrl', accessToken: 'access');
      when(mockUserRepository.login(userName: userName, password: password)).thenAnswer((_) async=> Future.value(Right(tUserInfo)));
      //ACT
      var result = await useCase(params: Params(userName: userName, password: password));
      //ASSERT
      expect(result, Right(tUserInfo));
      ///*checking arguments are the ones that are sent.
      verify(mockUserRepository.login(userName: userName, password: password));
      ///*checking that only has one and only one call.
      verifyNoMoreInteractions(mockUserRepository);
    });

    testWidgets('Should login a user unsuccessfully and retrieve failure', (tester) async {
      //ARRANGE
      var failure = ServerFailure('Could not reach server');
      when(mockUserRepository.login(userName: userName, password: password)).thenAnswer((_) async=> Future.value(Left(failure)));
      //ACT
      var result = await useCase(params: Params(userName: userName, password: password));
      //ASSERT
      expect(result, Left(failure));
      verify(mockUserRepository.login(userName: userName, password: password));
      verifyNoMoreInteractions(mockUserRepository);
    });
  });
}
