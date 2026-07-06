import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/featuers/home/home_controller.dart';
import 'package:provider/provider.dart';

import 'view_all_component.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 340,
        child: Stack(
          children: [
            SizedBox(
              height: 240,
              width: double.infinity,
              child: Image.asset("assets/images/backdround2.png", fit: BoxFit.cover),
            ),
            Positioned.fill(
              top: 70,
              child: Column(
                children: [
                  Text(
                    "NEWST",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, color: LightColor.primaryColor),
                  ),
                  SizedBox(height: 6),
                  ViewAllComponent(title: 'Trending News', onTap:(){},),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 140,
                    child: Consumer<HomeController>(
                      builder: (BuildContext context, controller, Widget? child) {
                        switch (controller.everythingStatus) {
                          case RequestStatusEnums.loading:
                            return Center(child: CircularProgressIndicator());
                          case RequestStatusEnums.error:
                            return Center(child: Text(controller.errorMessage!));
                          case RequestStatusEnums.loaded:
                            return ListView.separated(
                              padding: EdgeInsets.only(left: 16),
                              separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(width: 12);
                              },
                              itemCount: controller.newsEverythingList.take(6).length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final model = controller.newsEverythingList[index];
                                return Container(
                                  width: 240,
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(12),
                                    child: Stack(
                                      children: [
                                        if (model.urlToImage != null)
                                          Image.network(width: 240, height: 140, model.urlToImage!),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withValues(alpha: 0.5),
                                                  Colors.black.withValues(alpha: 0.7),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 12,
                                          right: 12,
                                          left: 12,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: Color(0xFFFFFCFC),
                                                ),
                                                maxLines: 2,
                                              ),
                                              SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage: NetworkImage(model.urlToImage.toString()),
                                                          radius: 10,
                                                        ),
                                                        SizedBox(width: 6),
                                                        Expanded(
                                                          child: Text(
                                                            model.author ?? "",
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 12,
                                                              color: Color(0xFFFFFCFC),
                                                            ),
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                  formatDate(model.publishedAt.toString()),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 16,
                                                      color: Color(0xFFFFFCFC),
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
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String date) {
    if (date == null) return "";
    final deff = DateTime.now().difference(DateTime.parse(date));
    if(deff.inMinutes < 60 )
    {
    return "${deff.inMinutes}m ago";
    }
    if(deff.inHours<24){
      return "${deff.inHours}h ago";
    }
    return "${deff.inDays}d ago";
  }
}
