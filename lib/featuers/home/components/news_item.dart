import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/extentions/data_time_extention.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/core/widgets/custtom_svg_picture.dart';
import 'package:news_app/featuers/%20details/news_details_screen.dart';
import 'package:news_app/core/widgets/bookmark_button.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});

  final NewsArticlesModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return NewsDetailsScreen(model: model,);
            },
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.pw16, vertical: AppSize.ph8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.r20),
              child: CustomCachedNetworkImage(imagePath: model.urlToImage ?? ""),
            ),
            SizedBox(width: AppSize.pw8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: AppSize.sp16,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      if (model.urlToImage != null)
                        CircleAvatar(
                          backgroundImage: NetworkImage(model.urlToImage!),
                          radius: 10,
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
                                fontSize: AppSize.sp12,
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
                                  fontSize: AppSize.sp12,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
