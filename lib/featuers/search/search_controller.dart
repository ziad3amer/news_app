import 'package:flutter/material.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repos/new_repository.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';

import '../../core/enums/request_status_enums.dart' show RequestStatusEnums;

class SearchScreenController extends ChangeNotifier with SafeNotify {
  RequestStatusEnums everythingStatus = RequestStatusEnums.loading;

  SearchScreenController(this.newsRpository);

  TextEditingController searchController = TextEditingController();
  final BaseNewsRpository newsRpository;



  List<NewsArticlesModel> newsEverythingList = [];
  String? errorMessage;

  getTopEverything() async {
    try {
      newsEverythingList = await newsRpository.getTopEverything(query: searchController.text);

      everythingStatus = RequestStatusEnums.loaded;
      errorMessage = null;
    } catch (e) {
      everythingStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }
}