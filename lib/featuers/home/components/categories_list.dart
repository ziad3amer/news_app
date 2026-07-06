import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/featuers/home/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
   CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
            child: SizedBox(
              height: 30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                padding: EdgeInsets.only(right: 16),
                itemBuilder: (BuildContext context, int index) {
                  bool isSelected = controller.selectedCategory == categories[index];
                  return GestureDetector(
                    onTap: (){
                      controller.updateSelectedCategory(categories[index]);
                    },
                    child: IntrinsicWidth(
                      child: Column(
                        children: [
                          Text(
                            categories[index][0].toUpperCase() + categories[index].substring(1) ,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF363636)),
                          ),
                          if(isSelected)
                            ...[
                              SizedBox(height: 4,),
                              Container(
                                height: 2,
                                color: LightColor.primaryColor,
                              )
                            ]
      
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 12);
                },
              ),
            ),
          );
        },
      
      ),
    );
  }

  final List<String> categories = ["business", "entertainment", "general", "health", "science", "sports", "technology"];
}
