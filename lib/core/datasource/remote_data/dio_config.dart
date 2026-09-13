//الـ Config = Configuration يعني ملف بنحط فيه الإعدادات والثوابت الخاصة بالـ API أو التطبيق.
import 'package:dio/dio.dart' show Dio, BaseOptions;
import 'package:dio/src/dio_mixin.dart';

import 'interceptor/auth_interceptor.dart';
import 'interceptor/login_interceptor.dart';

class DioConfig {
  static Dio createDio(){
    final dio= Dio(
      BaseOptions(
        baseUrl: "https://dummyjson.com/",
        connectTimeout: Duration(seconds: 30),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
        },
      )
    );
    dio.interceptors.addAll([LoggingInterceptor(),AuthInterceptor()]);


    return dio;
  }
}