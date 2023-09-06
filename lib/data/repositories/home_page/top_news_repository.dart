import 'package:english_news_app/data/app_exceptions/app_exceptions.dart';
import 'package:english_news_app/model/news_model.dart';
import 'package:english_news_app/resources/app_url/app_url.dart';
import 'package:english_news_app/services/api_services/api_services.dart';

class TopNewsRepository {
  final apiServices = ApiServices();

  Future<List<Article>> getTopNews(int page)async{
    String url = "${AppUrl.apiBaseUrl}/everything?q=news&pageSize=15&page=$page&apiKey=${AppUrl.apiKey}";
    try{
      final response = await apiServices.getApi(url);
      List<dynamic> newsData = response['articles'];
      return newsData.map((news) => Article.fromJson(news)).toList();
    }catch(e){
      throw UnknownException(e.toString());
    }
  }
}