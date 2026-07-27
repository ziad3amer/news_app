
import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/featuers/home/components/news_item.dart';
import 'package:news_app/featuers/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'top_headline_shimmer.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, Widget? child) {
        switch (controller.newsTopHeadlineStates) {
          case RequestStatusEnums.loading:
            return TopHeadlineShimmer();
          case RequestStatusEnums.error:
            return SliverToBoxAdapter(child: Center(child: Text(controller.errorMessage!)));
          case RequestStatusEnums.loaded:
            return SliverList.builder(
              itemCount: controller.newsTopHeadlineList.length,
              itemBuilder: (BuildContext context, int index) {
                final model = controller.newsTopHeadlineList[index];
                return NewsItem(model: model,);
              },
            );
        }
      },
    );
  }
}
