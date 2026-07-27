import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:shimmer/shimmer.dart' show Shimmer;

class TrendingNewsShimmer extends StatelessWidget {
  const TrendingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(left: AppSize.w16),
      itemCount:6,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: AppSize.pw12);
      },
      itemBuilder: (BuildContext context, int index) {
        return  Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(height: AppSize.h140, width:AppSize.w240, color: Colors.white),
        );
      },
    );
  }
}
