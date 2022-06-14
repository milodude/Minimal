import 'dart:convert';

import 'package:coda_test/features/login/data/model/user_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/failure.dart';
import '../../../../core/provider/url_provider.dart';

abstract class UserRepository{
  Future<UserModel> login({required String userName,required String password}); 
}

class UserDataSource implements UserRepository{
  final http.Client httpClient;
  final UrlProvider urlProvider;

  UserDataSource({required this.httpClient, required this.urlProvider});
  
  @override
  Future<UserModel> login({required String userName,required String password}) async {
    Uri uri = urlProvider.getUrl('/mia-auth/login',null);
    var response = await httpClient.get(uri, headers: {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Access-Control-Allow-Origin': '*',
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      UserModel userModel = UserModel.fromJson(json.decode(response.body));
      return userModel;
    } else {
      throw ServerFailure(
          'Something went wrong while logging in');
    }
  }

}