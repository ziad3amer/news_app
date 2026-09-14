import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/core/datasource/remote_data/auth/api_config.dart';

import 'news_api_config.dart';
import 'news_dio_config.dart';

abstract class BaseNewsApiService {
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params});
}

class NewsApiService extends BaseNewsApiService {
  final dio = NewsDioConfig.createDio();

  @override
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: {"apiKey": NewsApiConfig.apiKey, ...?params},
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.badResponse:
        case DioExceptionType.cancel:
        case DioExceptionType.connectionError:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
        case DioExceptionType.transformTimeout:
          throw e.message.toString();
      }
    } catch (e) {
      print("GET ERROR: $e");
      rethrow;
    }
  }
}
