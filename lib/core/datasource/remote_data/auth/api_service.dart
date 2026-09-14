import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/remote_data/auth/api_config.dart';

abstract class AuthBaseApiService {
  Future<dynamic> Post(String endpoint, String baseUrl, {Map<String, dynamic>? body});
}

class AuthApiService extends AuthBaseApiService {
  @override
  Future<dynamic> Post(
    String endpoint,
    String baseUrl, {
    Map<String, dynamic>? body,
  }) async {
    var url = Uri.https(baseUrl, endpoint);
    try {
      final http.Response response = await http.post(
        url,
        headers: {"accept": "application/json", "Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseBody;
      } else {
        throw Exception(responseBody["message"] ?? "Field To loud Data");
      }
    } catch (e) {
      print("POST ERROR: $e");
      rethrow;
    }
  }
}
