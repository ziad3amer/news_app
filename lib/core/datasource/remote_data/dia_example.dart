import 'package:dio/dio.dart' show Dio;
import 'package:news_app/core/datasource/remote_data/auth/auth_dio_config.dart';

class DiaExample {
  static final dio = DioConfig.createDio();

  static Future<void> exampleGetRequest() async {
    try {
      await dio.get('products');
    } catch (e) {}
  }

  static Future<void> exampleGetRequestWithQueryParameters() async {
     await dio.get('products/search', queryParameters: {'q': 'phone'});
  }

  static Future<void> examplePostRequest() async {
    await dio.post("products/add", data: {"title": 'BMW Pencil'});
  }

}
