import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';

class ViewAllComponent extends StatelessWidget {
  const ViewAllComponent({
    super.key,
    required this.title,
     this.titleColor,
    required this.onTap,
  });

  final String title;
  final Color? titleColor;
  final  Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:AppSize.w16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: AppSize.sp18, fontWeight: FontWeight.w700, color:titleColor?? Color(0xFFFFFCFC)),
          ),
          InkWell(
            onTap: (){
              onTap();
            },
            child: Text(
              "View all",
              style: TextStyle(
                fontSize: AppSize.sp14,
                fontWeight: FontWeight.w400,
                color:titleColor?? Color(0xFFFFFCFC),
                decoration: TextDecoration.underline,
                decorationColor:titleColor?? Color(0xFFFFFCFC),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
