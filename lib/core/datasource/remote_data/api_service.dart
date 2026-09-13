import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/remote_data/api_config.dart';

abstract class BaseApiService {
  Future<dynamic> get(
      String endpoint,
      String baseUrl, {
        Map<String, dynamic>? params,
      });

  Future<dynamic> getWithToken(
      String endpoint,
      String baseUrl,
      String token,
      );

  Future<dynamic> Post(
      String endpoint,
      String baseUrl, {
        Map<String, dynamic>? body,
      });
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
      "v2/$endpoint",
      {
        "apiKey": ApiConfig.apiKey,
        ...?params,
      },
    );

    print("GET URL: $url");

    try {
      final http.Response response = await http.get(
        url,
        headers: {
          "accept": "application/json",
        },
      );

      print("GET STATUS CODE: ${response.statusCode}");
      print("GET RESPONSE: ${response.body}");

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print("GET ERROR: $e");
      rethrow;
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
      endpoint,
    );
    try {
      final http.Response response = await http.post(
        url,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      final responseBody =
      jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 &&
          response.statusCode < 300) {
        return responseBody;
      } else {
        throw Exception(
          responseBody["message"] ?? "Field To loud Data",
        );
      }
    } catch (e) {
      print("POST ERROR: $e");
      rethrow;
    }
  }

  @override
  Future<dynamic> getWithToken(
      String endpoint,
      String baseUrl,
      String token,
      ) async {
    var url = Uri.https(
      baseUrl,
      endpoint,
    );

    print("GET WITH TOKEN URL: $url");

    try {
      final http.Response response = await http.get(
        url,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("GET WITH TOKEN STATUS CODE: ${response.statusCode}");
      print("GET WITH TOKEN RESPONSE: ${response.body}");

      final responseBody =
      jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 &&
          response.statusCode < 300) {
        return responseBody;
      } else {
        throw Exception(
          responseBody["message"] ?? "Field To loud Data",
        );
      }
    } catch (e) {
      print("GET WITH TOKEN ERROR: $e");
      rethrow;
    }
  }
}