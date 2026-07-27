
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';

import '../../../core/datasource/remote_data/api_config.dart';

class NewRepository {
  //ApiService apiService = ApiService();

  Future<List<NewsArticlesModel>> getTopHeadline({String? selectedCategory = "general"}) async {
    Map<String, dynamic> result = await ApiService().get(
      ApiConfig.topHeadlines,
      params: {"country": "us", "category": selectedCategory},
    );
    return (result["articles"] as List).map((e) => NewsArticlesModel.fromJson(e)).toList();
  }

  Future<List<NewsArticlesModel>>getTopEverything()async{
    Map<String, dynamic> result = await ApiService().get(
      ApiConfig.everything,
      params: {"q": "Ai"},
    );

    return (result["articles"] as List)
        .map((e) => NewsArticlesModel.fromJson(e))
        .toList();

  }
}
