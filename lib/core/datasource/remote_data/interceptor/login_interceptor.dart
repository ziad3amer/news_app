import 'dart:developer';

import 'package:dio/dio.dart' show Interceptor, RequestOptions, RequestInterceptorHandler, Response, ResponseInterceptorHandler, DioException, ErrorInterceptorHandler;

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("Baseurl = ${options.baseUrl}");
    log("Method = ${options.method}");

    if (options.queryParameters.isNotEmpty) {
      log("Query Parameters = ${options.queryParameters}");
    }
    if (options.data != null) {
      log("Body = ${options.data}");
    }
    handler.next(options);
  }
  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    log("Response = ${response.data}");
    handler.next(response);
  }
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("Baseurl = ${err.requestOptions.baseUrl}");
    log("Method = ${err.requestOptions.method}");

    if (err.requestOptions.queryParameters.isNotEmpty) {
      log("Query Parameters = ${err.requestOptions.queryParameters}");
    }
    if (err.requestOptions.data != null) {
      log("Body = ${err.requestOptions.data}");
    }
    log("Error");
    log(" type${err.type}");
    log(" message${err.message}");
    log(" statusCode${err.response?.statusCode}");
    handler.next(err);

  }
}
