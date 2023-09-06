import 'package:english_news_app/model/news_model.dart';
import 'package:english_news_app/resources/app_url/app_url.dart';
import 'package:english_news_app/services/api_services/api_services.dart';

class CategoryNewsRepository{

  final apiServices = ApiServices();

  Future<List<Article>> getCategoryNews(String category,int page) async{
    String url = "${AppUrl.apiBaseUrl}/top-headlines?country=us&category=$category&page=$page&apiKey=${AppUrl.apiKey}";
    final response = await apiServices.getApi(url);
    List<dynamic> newsData = response["articles"];
    return newsData.map((news) => Article.fromJson(news)).toList();
  }
}