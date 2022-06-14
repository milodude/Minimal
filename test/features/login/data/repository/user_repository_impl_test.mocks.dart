// Mocks generated by Mockito 5.2.0 from annotations
// in coda_test/test/features/login/data/repository/user_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:coda_test/core/provider/url_provider.dart' as _i3;
import 'package:coda_test/features/login/data/data_source/user_data_source.dart'
    as _i5;
import 'package:coda_test/features/login/data/model/user_model.dart' as _i4;
import 'package:http/http.dart' as _i2;
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

class _FakeClient_0 extends _i1.Fake implements _i2.Client {}

class _FakeUrlProvider_1 extends _i1.Fake implements _i3.UrlProvider {}

class _FakeUserModel_2 extends _i1.Fake implements _i4.UserModel {}

/// A class which mocks [UserDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserDataSource extends _i1.Mock implements _i5.UserDataSource {
  MockUserDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get httpClient =>
      (super.noSuchMethod(Invocation.getter(#httpClient),
          returnValue: _FakeClient_0()) as _i2.Client);
  @override
  _i3.UrlProvider get urlProvider =>
      (super.noSuchMethod(Invocation.getter(#urlProvider),
          returnValue: _FakeUrlProvider_1()) as _i3.UrlProvider);
  @override
  _i6.Future<_i4.UserModel> login({String? userName, String? password}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #login, [], {#userName: userName, #password: password}),
              returnValue: Future<_i4.UserModel>.value(_FakeUserModel_2()))
          as _i6.Future<_i4.UserModel>);
}