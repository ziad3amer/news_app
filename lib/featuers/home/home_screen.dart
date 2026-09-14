import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/datasource/remote_data/auth/api_service.dart';
import 'package:news_app/core/repos/new_repository.dart';

import 'package:news_app/featuers/home/components/categories_list.dart';
import 'package:news_app/featuers/home/components/top_headline.dart';
import 'package:news_app/featuers/home/components/trending_news.dart';
import 'package:news_app/featuers/home/components/view_all_component.dart';
import 'package:news_app/featuers/home/cubit/home_cubit.dart';
import 'package:news_app/featuers/home/home_controller.dart';
import 'package:provider/provider.dart';

import '../../core/datasource/remote_data/news/news_api_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(NewRepository(NewsApiService())),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [TrendingNews(), CategoriesList(), TopHeadline()],
        ),
      ),
    );
  }
}
