import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/featuers/home/categories_screen.dart';
import 'package:news_app/featuers/home/components/view_all_component.dart';
import 'package:news_app/featuers/home/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Column(
            children: [
              ViewAllComponent(
                title: 'Categories',
                titleColor: Color(0xFF141414),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ChangeNotifierProvider.value(
                        value: controller,
                        child: CategoriesScreen());
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding:  EdgeInsets.only(left: AppSize.pw16, top:AppSize.ph16, bottom:AppSize.ph16),
                child: SizedBox(
                  height: AppSize.h30,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    padding: EdgeInsets.only(right: AppSize.pw16),
                    itemBuilder: (BuildContext context, int index) {
                      bool isSelected = controller.selectedCategory == categories[index];
                      return GestureDetector(
                        onTap: () {
                          controller.updateSelectedCategory(categories[index]);
                        },
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Text(
                                categories[index][0].toUpperCase() + categories[index].substring(1),
                                style: TextStyle(fontSize:AppSize.sp16, fontWeight: FontWeight.w400, color: Color(0xFF363636)),
                              ),
                              if (isSelected) ...[
                                SizedBox(height:AppSize.ph4),
                                Container(height: AppSize.ph2, color: LightColor.primaryColor),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width:AppSize.pw12);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  final List<String> categories = ["business", "entertainment", "general", "health", "science", "sports", "technology"];
}
