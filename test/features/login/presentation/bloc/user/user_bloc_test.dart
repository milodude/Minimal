import 'package:bloc_test/bloc_test.dart';
import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/features/login/domain/entities/user_info.dart';
import 'package:coda_test/features/login/domain/use_cases/user_login.dart';
import 'package:coda_test/features/login/presentation/bloc/user/user_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_bloc_test.mocks.dart';


@GenerateMocks([UserLogin])
void main() {
  MockUserLogin mockUserLogin = MockUserLogin();
  late UserBloc bloc = UserBloc(userLoginUseCase: mockUserLogin);

  UserInfo tUserinfo = const UserInfo(id: 7, firstName: 'Matt', lastName: 'Raverta', email: 'milodude023@gmail.com', photo: '', accessToken: '');
  group('User BLOC: ', () {
    setUp(() {
      bloc.close();
      bloc = UserBloc(userLoginUseCase: mockUserLogin);
    });

    blocTest('emits [] when nothing is added',
        build: () => bloc,
        expect: () => [],
        wait: const Duration(milliseconds: 500));

    blocTest<UserBloc, UserState>(
        'emits [Loading, Error] when getting my watchlists fails.',
        setUp: () => when(mockUserLogin(params: const Params(userName: 'Matt', password: '123456'))).thenAnswer(
            (realInvocation) async =>
                Future.value(Left(ServerFailure(serverException)))),
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(const LoginEvent(userName: 'Matt', password: '123456')),
        expect: () =>
            <UserState>[const Loading(), const Error(errorMessage: serverException)],
        wait: const Duration(milliseconds: 500));

    blocTest<UserBloc, UserState>(
        'emits [Loading, Loaded] when getting my watchlists.',
        setUp: () => when(mockUserLogin(params: const Params(userName: 'Matt', password: '123456'))).thenAnswer(
            (realInvocation) async => Future.value(Right(tUserinfo))),
        build: () {
          return bloc;
        },
        act: (bloc) => bloc.add(const LoginEvent(userName: 'Matt', password: '123456')),
        expect: () => <UserState>[const Loading(), Loaded(tUserinfo)],
        tearDown: bloc.close,
        wait: const Duration(milliseconds: 500));
  });
}
