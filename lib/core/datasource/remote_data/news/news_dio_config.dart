//الـ Config = Configuration يعني ملف بنحط فيه الإعدادات والثوابت الخاصة بالـ API أو التطبيق.
import 'package:dio/dio.dart' show Dio, BaseOptions;
import 'package:news_app/core/datasource/remote_data/interceptor/login_interceptor.dart';

import '../api_config.dart';

class NewsDioConfig {
  static Dio createDio(){
    final dio= Dio(
      BaseOptions(
        baseUrl: ApiConfig.newsBaseUrl,
        connectTimeout: Duration(seconds: 30),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
        },
      )
    );
    dio.interceptors.addAll([LoggingInterceptor()]);


    return dio;
  }
}