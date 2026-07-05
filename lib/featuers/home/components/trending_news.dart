import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/featuers/home/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: Stack(
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Image.asset(
                "assets/images/backdround2.png", fit: BoxFit.cover),
          ),
          Positioned.fill(
            top: 70,
            child: Column(
              children: [
                Text(
                  "NEWST",
                  style: TextStyle(fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: LightColor.primaryColor),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending News",
                        style: TextStyle(fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Text(
                        "View all",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
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
                            separatorBuilder: (BuildContext context,
                                int index) {
                              return SizedBox(width: 12);
                            },
                            itemCount: controller.newsEverythingList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(12),
                                child: Stack(
                                  children: [
                                    if (controller.newsEverythingList[index]
                                        .urlToImage != null)
                                      Image.network(
                                        width: 240,
                                          height: 140,
                                          controller.newsEverythingList[index]
                                              .urlToImage!,
                                      ),
                                    Positioned.fill(
                                     child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                         end: Alignment.bottomCenter,
                                         colors: [
                                           Colors.black.withValues(alpha: 0.5),
                                           Colors.black.withValues(alpha: 0.7),

                                         ]
                                        )
                                      ),
                                     ),),
                                  ],
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
    );
  }
}
