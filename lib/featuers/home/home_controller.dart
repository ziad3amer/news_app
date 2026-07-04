import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';

class HomeController with ChangeNotifier {

  HomeController(){
    getTopHeadline();
    getTopEverything();
  }






  bool topHeadlineLoading = true;
  bool everythingLoading = true;
  String? errorMessage;
  List<NewsArticlesModel> newsTopHeadlineList = [];
  List<NewsArticlesModel> newsEverythingList = [];
  ApiService apiService = ApiService();

  getTopHeadline() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us"},
      );

      newsTopHeadlineList = (result["articles"] as List)
          .map((e) => NewsArticlesModel.fromJson(e))
          .toList();

      topHeadlineLoading = false;
      errorMessage = null;
    } catch (e) {
      topHeadlineLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  getTopEverything() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.everything,
        params: {"q": "Ai"},
      );

      newsEverythingList = (result["articles"] as List)
          .map((e) => NewsArticlesModel.fromJson(e))
          .toList();

      everythingLoading = false;
      errorMessage = null;
    } catch (e) {
      everythingLoading = false;
      errorMessage = e.toString();
    }
      notifyListeners();
  }
}
