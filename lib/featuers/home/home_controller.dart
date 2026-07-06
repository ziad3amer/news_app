import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';

class HomeController with ChangeNotifier {

  HomeController(){
    getTopHeadline();
    getTopEverything();
  }


  RequestStatusEnums everythingStatus =RequestStatusEnums.loading;


  bool topHeadlineLoading = true;

  String? errorMessage;
  String? selectedCategory ;
  List<NewsArticlesModel> newsTopHeadlineList = [];
  List<NewsArticlesModel> newsEverythingList = [];
  ApiService apiService = ApiService();

  getTopHeadline({String? category}) async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {
          "country": "us",
          "category":selectedCategory,

        },
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

  getTopEverything({String? category}) async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.everything,
        params: {"q": "Ai"},
      );

      newsEverythingList = (result["articles"] as List)
          .map((e) => NewsArticlesModel.fromJson(e))
          .toList();

      everythingStatus = RequestStatusEnums.loaded;
      errorMessage = null;
    } catch (e) {
      everythingStatus = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
      notifyListeners();
  }

  void updateSelectedCategory(String category) {
    selectedCategory=category;
    getTopHeadline(category:selectedCategory);
    notifyListeners();
  }
}
