import 'package:english_news_app/model/news_model.dart';
import 'package:english_news_app/resources/app_url/app_url.dart';
import 'package:english_news_app/services/api_services/api_services.dart';

class BreakingNewsRepository {
  final apiServices = ApiServices();

  Future<List<Article>> getBreakingNews(int page)async{
    String url = "${AppUrl.apiBaseUrl}/top-headlines?country=us&pageSize=10&page=$page&apiKey=${AppUrl.apiKey}";
    final jsonData = await apiServices.getApi(url);
    List<dynamic> breakingNews = jsonData['articles'];
    return breakingNews.map((e) => Article.fromJson(e)).toList();
  }
}