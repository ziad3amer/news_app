import 'dart:convert' show jsonDecode;
import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/remote_data/api_config.dart';

class ApiService {

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params}) async {
    var url = Uri.http(
        ApiConfig.baseUrl,
        //this is qaure parameters
        "v2/$endpoint", {
      "apiKey": ApiConfig.apiKey,
      ...?params,
    });
    print(url);
    try{

      final http.Response response = await http.get(url);
      return jsonDecode(response.body) as Map<String, dynamic>;
    }catch(e)
    {
      throw Exception("Field To loud Data");
    }



  }
}
