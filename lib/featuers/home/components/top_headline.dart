
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder;
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/featuers/home/components/news_item.dart';
import 'package:news_app/featuers/home/cubit/home_cubit.dart';
import 'package:news_app/featuers/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'top_headline_shimmer.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context, state) {
        switch (state.newsTopHeadlineStates) {
          case RequestStatusEnums.loading:
            return TopHeadlineShimmer();
          case RequestStatusEnums.error:
            return SliverToBoxAdapter(child: Center(child: Text(state.errorMessage!)));
          case RequestStatusEnums.loaded:
            return SliverList.builder(
              itemCount: state.newsTopHeadlineList.length,
              itemBuilder: (BuildContext context, int index) {
                final model = state.newsTopHeadlineList[index];
                return NewsItem(model: model,);
              },
            );
        }
      },
    );
  }
}
