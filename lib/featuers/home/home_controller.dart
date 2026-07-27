import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';
import 'package:news_app/featuers/home/repos/new_repository.dart' show NewRepository;

class HomeController with ChangeNotifier {

  HomeController(this.newRepository){
    getTopHeadline();
    getTopEverything();
  }


  RequestStatusEnums everythingStatus =RequestStatusEnums.loading;
  RequestStatusEnums newsTopHeadlineStates =RequestStatusEnums.loading;




  String? errorMessage;
  String? selectedCategory ;
  List<NewsArticlesModel> newsTopHeadlineList = [];
  List<NewsArticlesModel> newsEverythingList = [];
  final NewRepository newRepository ;

  getTopHeadline({String? category}) async {
    try {
      newsTopHeadlineStates =RequestStatusEnums.loading;
      notifyListeners();
      newsTopHeadlineList = await newRepository.getTopHeadline(selectedCategory: selectedCategory);

      newsTopHeadlineStates = RequestStatusEnums.loaded;
      errorMessage = null;
    } catch (e) {
      newsTopHeadlineStates = RequestStatusEnums.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  getTopEverything({String? category}) async {
    try {

      newsEverythingList =await newRepository.getTopEverything();

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
