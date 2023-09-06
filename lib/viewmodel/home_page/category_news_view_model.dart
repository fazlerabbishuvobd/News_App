import 'package:english_news_app/data/api_response/api_response.dart';
import 'package:english_news_app/data/repositories/home_page/category_news_respository.dart';
import 'package:english_news_app/model/news_model.dart';
import 'package:get/get.dart';

class CategoryNewsViewModel extends GetxController{


  RxInt page = 1.obs;

  final categoryNewsApiResponse = ApiResponse<List<Article>>.loading().obs;
  final categoryNewsList = <Article>[].obs;

  RxBool hasMoreNews = true.obs;
  RxBool isLoading = false.obs;

  Future<void> getCategoryNews(String category) async{
    try{
      categoryNewsApiResponse.value = ApiResponse.loading();

      final categoryNews = await CategoryNewsRepository().getCategoryNews(category, page.value++);
      categoryNewsList.addAll(categoryNews);
      categoryNewsApiResponse.value = ApiResponse.completed(categoryNews);

    }catch(e){
      categoryNewsApiResponse.value = ApiResponse.error(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> loadMoreCategoryNews(String category) async{
    try{
      final categoryNews = await CategoryNewsRepository().getCategoryNews(category, ++page.value);
      if(categoryNews.length <20)
        {
          hasMoreNews.value = false;
        }
      categoryNewsList.addAll(categoryNews);
      categoryNewsApiResponse.value = ApiResponse.completed(categoryNews);

    }catch(e){
      categoryNewsApiResponse.value = ApiResponse.error(e.toString());
      throw Exception(e.toString());
    }
  }
}