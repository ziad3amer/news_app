import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:shimmer/shimmer.dart' show Shimmer;

class TopHeadlineShimmer extends StatelessWidget {
  const TopHeadlineShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return  Padding(
          padding:  EdgeInsets.all(AppSize.pw16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(height:AppSize.h80, color: Colors.white),
          ),
        );
      },
    );
  }
}
