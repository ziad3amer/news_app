import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../featuers/auth/login_screen.dart';
import '../../../../main.dart';

import '../../local_data/preferences_mangar.dart';
import '../../local_data/user_repository.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = UserRepository().getUser()?.token;

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";

      handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      final BuildContext context = navigatorKey.currentContext!;

      UserRepository().deleteUser();
      PreferencesMangar().clear();
      Navigator.of(context).pushNamedAndRemoveUntil(
        MaterialPageRoute(
              builder: (BuildContext context) {
                return LoginScreen();
              },
            )
            as String,
        (route) => false,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Session Expired")));
    }
    handler.next(err);
  }
}
