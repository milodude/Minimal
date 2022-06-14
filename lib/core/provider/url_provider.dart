import 'package:coda_test/core/constants/access.dart';

class UrlProvider {
  
  Uri getUrl(String path, Map<String, dynamic>? params){
    String enviromentUrl = _getUrl();

    if(params == null){
      return Uri.https(enviromentUrl, path);
    }else{
      return Uri.https(enviromentUrl, path, params);
    }
  }

  String _getUrl()=> serverUrl;
}
