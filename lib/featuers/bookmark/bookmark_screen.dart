import 'package:flutter/material.dart';
import 'package:news_app/featuers/bookmark/bookmark_controller.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => BookmarkController(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bookmark"),
          centerTitle: true,
          actions: [

          ],
        ),
      ),
    );
  }
}
