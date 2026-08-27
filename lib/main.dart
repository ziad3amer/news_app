import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/theme/light_theme.dart';
import 'package:news_app/featuers/bookmark/data/bookmark_repository.dart';
import 'package:news_app/featuers/home/home_controller.dart';
import 'package:news_app/featuers/home/home_screen.dart';
import 'package:news_app/featuers/main/main_screen.dart';
import 'package:news_app/featuers/onpording/onboarding_screen.dart';
import 'package:news_app/featuers/splash/splash_screen.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await PreferencesMangar().init();

  //  الاتنين اللي تحت دووول واخدين await المفروض
  await UserRepository().init();
  await BookmarkRepository().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 832),
      minTextAdapt: true,

        builder: (ctx ,_) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            home: SplashScreen(),
          );
        }
    );
  }
}
