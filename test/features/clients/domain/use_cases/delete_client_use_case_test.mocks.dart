// Mocks generated by Mockito 5.2.0 from annotations
// in coda_test/test/features/clients/domain/use_cases/delete_client_use_case_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:coda_test/core/error/failure.dart' as _i5;
import 'package:coda_test/features/clients/domain/entities/client.dart' as _i6;
import 'package:coda_test/features/clients/domain/repository/client_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [ClientRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockClientRepository extends _i1.Mock implements _i3.ClientRepository {
  MockClientRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.ClientData>>> getClientList() =>
      (super.noSuchMethod(Invocation.method(#getClientList, []),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i6.ClientData>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.ClientData>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.ClientData>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ClientData>> addClient(
          _i6.ClientData? clientData) =>
      (super.noSuchMethod(Invocation.method(#addClient, [clientData]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.ClientData>>.value(
              _FakeEither_0<_i5.Failure, _i6.ClientData>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.ClientData>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> deleteClient(int? clientId) =>
      (super.noSuchMethod(Invocation.method(#deleteClient, [clientId]),
              returnValue: Future<_i2.Either<_i5.Failure, void>>.value(
                  _FakeEither_0<_i5.Failure, void>()))
          as _i4.Future<_i2.Either<_i5.Failure, void>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ClientData>> editClient(
          _i6.ClientData? clientData) =>
      (super.noSuchMethod(Invocation.method(#editClient, [clientData]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.ClientData>>.value(
              _FakeEither_0<_i5.Failure, _i6.ClientData>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.ClientData>>);
}

/// A class which mocks [ClientRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockClientRepositoryVoid extends _i1.Mock
    implements _i3.ClientRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.ClientData>>> getClientList() =>
      (super.noSuchMethod(Invocation.method(#getClientList, []),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i6.ClientData>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.ClientData>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.ClientData>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ClientData>> addClient(
          _i6.ClientData? clientData) =>
      (super.noSuchMethod(Invocation.method(#addClient, [clientData]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.ClientData>>.value(
              _FakeEither_0<_i5.Failure, _i6.ClientData>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.ClientData>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> deleteClient(int? clientId) =>
      (super.noSuchMethod(Invocation.method(#deleteClient, [clientId]),
              returnValue: Future<_i2.Either<_i5.Failure, void>>.value(
                  _FakeEither_0<_i5.Failure, void>()))
          as _i4.Future<_i2.Either<_i5.Failure, void>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ClientData>> editClient(
          _i6.ClientData? clientData) =>
      (super.noSuchMethod(Invocation.method(#editClient, [clientData]),
          returnValue: Future<_i2.Either<_i5.Failure, _i6.ClientData>>.value(
              _FakeEither_0<_i5.Failure, _i6.ClientData>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.ClientData>>);
}
