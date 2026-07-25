import 'dart:convert';
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/extentions/data_time_extention.dart';
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
            body: CustomScrollView(
              slivers: [
                TrendingNews(),
                SliverToBoxAdapter(
                  child: ViewAllComponent(title: 'Categories', titleColor: Color(0xFF141414), onTap: () {}),
                ),
                CategoriesList(),
                SliverList.builder(
                  itemCount: controller.newsTopHeadlineList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final model = controller.newsTopHeadlineList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(model.urlToImage ?? "", height: 80, width: 140, fit: BoxFit.cover),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(backgroundImage: NetworkImage(model.urlToImage ?? ""), radius: 10),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Text(
                                            (model.author ?? "").substring(0,min((model.author??"").length, 10)),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF141414),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: 8,),
                                          Text(
                                            model.publishedAt.formateDateTime() ,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF141414),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
