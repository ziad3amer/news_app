import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/featuers/%20details/news_details_screen.dart';
import 'package:provider/provider.dart';

import '../../core/repos/new_repository.dart';
import 'search_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return SearchScreenController(NewRepository(ApiService()));
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Search"), centerTitle: true),
        body: Padding(
          padding: EdgeInsets.all(AppSize.pw16),
          child: Consumer<SearchScreenController>(
            builder: (BuildContext context, SearchScreenController controller, Widget? child) {
              return Column(
                children: [
                  TextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.getTopEverything();
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: Icon(Icons.search, size: AppSize.r30, color: Color(0xFFA0A0A0)),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.newsEverythingList.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        final model = controller.newsEverythingList[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                return NewsDetailsScreen(model: model,);
                              },),);
                            },
                            leading: Icon(Icons.search, size: AppSize.r20, color: Color(0xFFA0A0A0)),
                            title: Text(model.title, maxLines: 1),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(color: Color(0xFFA0A0A0));
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
