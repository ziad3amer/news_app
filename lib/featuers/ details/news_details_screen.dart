import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/extentions/data_time_extention.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custtom_svg_picture.dart';
import 'package:news_app/featuers/bookmark/model/bookmark_button.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.model});

  final NewsArticlesModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Details"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSize.pw16),
          child: Column(
            children: [
              SizedBox(height: AppSize.ph8),
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(AppSize.r4),
                child: CustomCachedNetworkImage(
                  imagePath: model.urlToImage ?? "",
                  height: AppSize.h200,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: AppSize.ph14),
              Text(
                model.title ?? "",
                style: TextStyle(fontSize: AppSize.sp20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: AppSize.ph16),
              Row(
                children: [
                  if (model.urlToImage != null)
                    CircleAvatar(
                      backgroundImage: NetworkImage(model.urlToImage!),
                      radius: 16,
                    ),
                  SizedBox(width: AppSize.pw6),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          (model.author ?? "").substring(
                            0,
                            min((model.author ?? "").length, 10),
                          ),
                          style: TextStyle(
                            fontSize: AppSize.sp14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF141414),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: AppSize.pw8),
                        Expanded(
                          child: Text(
                            model.publishedAt.formateDateTime(),
                            style: TextStyle(
                              fontSize: AppSize.sp14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF141414),
                            ),
                          ),
                        ),
                        BookmarkButton(
                          article: model,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSize.pw16),
              Text(
                model.description ?? "",
                style: TextStyle(fontSize: AppSize.sp16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
