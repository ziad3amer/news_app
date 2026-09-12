import 'dart:convert' show jsonDecode, jsonEncode;
import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/remote_data/api_config.dart';

abstract class BaseApiService {
  Future<dynamic> get(String endpoint, String baseUrl, {Map<String, dynamic>? params});

  Future<dynamic> getWithToken(String endpoint, String baseUrl, String token);

  Future<dynamic> Post(String endpoint, String baseUrl, {Map<String, dynamic>? body});
}

class ApiService extends BaseApiService {
  @override
  Future<dynamic> get(
    String endpoint,
    String baseUrl, {
    Map<String, dynamic>? params,
  }) async {
    var url = Uri.http(
      baseUrl,
      //this is qaure parameters
      "v2/$endpoint",
      {"apiKey": ApiConfig.apiKey, ...?params},
    );
    print(url);
    try {
      final http.Response response = await http.get(
        url,
        headers: {"accept": "application/json"},
      );
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Field To loud Data");
    }
  }

  @override
  Future<dynamic> Post(
    String endpoint,
    String baseUrl, {
    Map<String, dynamic>? body,
  }) async {
    var url = Uri.https(
      baseUrl,
      //this is qaure parameters
      endpoint,
    );
    try {
      final http.Response response = await http.post(
        url,
        headers: {"accept": "application/json", "Content-Type": "application/json"},
      );
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseBody;
      } else {
        throw Exception(responseBody["message"] ?? "Field To loud Data");
      }
    } catch (e) {
      throw Exception("Field To loud Data");
    }
  }

  @override
  Future<dynamic> getWithToken(String endpoint, String baseUrl, String token) async {
    var url = Uri.https(
      baseUrl,
      //this is qaure parameters
      endpoint,
    );
    try {
      final http.Response response = await http.get(
        url,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseBody;
      } else {
        throw Exception(responseBody["message"] ?? "Field To loud Data");
      }
    } catch (e) {
      throw Exception("Field To loud Data");
    }
  }
}
