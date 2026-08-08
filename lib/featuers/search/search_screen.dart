import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(AppSize.pw16),
        child: Column(
          children: [
           TextField(
             controller:controller,
             decoration: InputDecoration(
             hintText: "Search",
             suffixIcon: Icon(Icons.search,size:AppSize.r30,color: Color(0xFFA0A0A0),)  
             ),
           ),
          ],
        ),
      ),
    );
  }
}
