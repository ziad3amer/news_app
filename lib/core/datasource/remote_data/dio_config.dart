//الـ Config = Configuration يعني ملف بنحط فيه الإعدادات والثوابت الخاصة بالـ API أو التطبيق.
import 'package:dio/dio.dart' show Dio, BaseOptions;

class DioConfig {
  static Dio createDio(){
    return Dio(
      BaseOptions(
        baseUrl: "https://dummyjson.com/",
        connectTimeout: Duration(seconds: 30),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
        },
      )
    );
  }
}