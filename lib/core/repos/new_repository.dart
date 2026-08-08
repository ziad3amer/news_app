
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';
import '../../../core/datasource/remote_data/api_config.dart';


abstract class BaseNewsRpository
{
  Future<List<NewsArticlesModel>> getTopHeadline({String? selectedCategory = "general"});
  Future<List<NewsArticlesModel>>getTopEverything({String query="news"});
}




class NewRepository extends BaseNewsRpository {


  final BaseApiService apiService;

  NewRepository(this.apiService);
  @override
  Future<List<NewsArticlesModel>> getTopHeadline({String? selectedCategory = "general"}) async {
    Map<String, dynamic> result = await apiService.get(
      ApiConfig.topHeadlines,
      params: {"country": "us", "category": selectedCategory},
    );
    return (result["articles"] as List).map((e) => NewsArticlesModel.fromJson(e)).toList();
  }

  Future<List<NewsArticlesModel>>getTopEverything({String query="news"})  async{
    Map<String, dynamic> result = await apiService.get(
      ApiConfig.everything,
      params: {"q": query},
    );

    return (result["articles"] as List)
        .map((e) => NewsArticlesModel.fromJson(e))
        .toList();

  }
}
