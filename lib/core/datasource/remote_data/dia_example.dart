import 'package:dio/dio.dart' show Dio;

class DiaExample {

  static Future<void>exampleGetRequest()async{
    final dio=Dio();

    final response = await dio.get('https://dummyjson.com/products');
    print(response.data);

  }
}