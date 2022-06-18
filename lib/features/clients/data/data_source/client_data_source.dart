import 'dart:convert';

import '../model/client_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/failure.dart';
import '../../../../core/provider/url_provider.dart';

abstract class ClientRepository {
  Future<List<ClientModel>> getClients();
  Future<ClientModel> addClient(ClientModel clientModel);
}

class ClientDataSource implements ClientRepository {
  final http.Client httpClient;
  final UrlProvider urlProvider;

  ClientDataSource({required this.httpClient, required this.urlProvider});

  @override
  Future<List<ClientModel>> getClients() async {
    Uri uri = urlProvider.getUrl('/client/list', { });
    
    var response = await httpClient.post(uri,body: json.encode({}), headers: {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*',
    });
    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      if (decodedJson['success'] == true) {
        List<ClientModel> clientList = <ClientModel>[];
        List<dynamic> responseList = decodedJson['response']['data'];
        for (Map<String, dynamic> item in responseList) {
          var client = ClientModel.fromJson(item);
          clientList.add(client);
        }
        return clientList;
      } else {
        throw ServerFailure(decodedJson['error']['message']);
      }
    } else {
      throw ServerFailure('Something went wrong while requesting clients list');
    }
  }
  
  @override
  Future<ClientModel> addClient(ClientModel clientModel) {
    // TODO: implement addClient
    throw UnimplementedError();
  }
}
