import 'package:flutter/material.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repos/new_repository.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';

import '../../core/enums/request_status_enums.dart' show RequestStatusEnums;

class SearchController extends ChangeNotifier with SafeNotify {
  RequestStatusEnums everythingStatus = RequestStatusEnums.loading;

  SearchController(this.newsRpository);
  final BaseNewsRpository newsRpository;



  List<NewsArticlesModel> newsEverythingList = [];
  String? errorMessage;

  getTopEverything({String? category}) async {
    try {
      newsEverythingList = await newsRpository.getTopEverything();

      everythingStatus = RequestStatusEnums.loaded;
      errorMessage = null;
    } catch (e) {
      everythingStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }
}