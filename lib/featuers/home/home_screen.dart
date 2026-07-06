import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/featuers/home/components/categories_list.dart';
import 'package:news_app/featuers/home/components/trending_news.dart';
import 'package:news_app/featuers/home/components/view_all_component.dart';
import 'package:news_app/featuers/home/home_controller.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            body: Column(
              children: [
                TrendingNews(),
                ViewAllComponent(title: 'Categories', titleColor: Color(0xFF141414), onTap: () {}),
                CategoriesList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
