import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/repos/new_repository.dart';

import 'package:news_app/featuers/home/components/categories_list.dart';
import 'package:news_app/featuers/home/components/top_headline.dart';
import 'package:news_app/featuers/home/components/trending_news.dart';
import 'package:news_app/featuers/home/components/view_all_component.dart';
import 'package:news_app/featuers/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController(NewRepository(ApiService())),
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(body: CustomScrollView(slivers: [TrendingNews(), CategoriesList(), TopHeadline()]));
        },
      ),
    );
  }
}
