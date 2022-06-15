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
    final queryParameters = {
      'email': userName,
      'password': password
    };
    Uri uri = urlProvider.getUrl('/mia-auth/login',queryParameters);
    var response = await httpClient.get(uri, headers: {
      'Content-type': 'application/json',
      'Accept': 'text/plain',
      'Access-Control-Allow-Origin': '*',
    });
    if (response.statusCode == 200) {
    var decodedJson = json.decode(response.body);
      if(decodedJson['success'] == true){
        UserModel userModel = UserModel.fromJson(decodedJson);
        return userModel;
      }else{
          throw ServerFailure(decodedJson['error']['message']);
      }
    } else {
      throw ServerFailure(
          'Something went wrong while logging in');
    }
  }

}