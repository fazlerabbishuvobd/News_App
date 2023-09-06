import 'package:english_news_app/data/api_response/api_response.dart';
import 'package:english_news_app/data/repositories/home_page/breaking_news_repository.dart';
import 'package:english_news_app/model/news_model.dart';
import 'package:get/get.dart';

class AllBreakingNewsViewModel extends GetxController{
  RxInt page = 1.obs;
  RxBool hasMoreAllBreakingNews = true.obs;
  RxBool isLoading = false.obs;

  final allBreakingNewsApiResponse = ApiResponse<List<Article>>.loading().obs;
  final allBreakingNewsList = <Article>[].obs;

  Future<void> getAllBreakingNews() async {
    try {
      allBreakingNewsApiResponse.value = ApiResponse.loading();
      final breakingNews = await BreakingNewsRepository().getBreakingNews(page.value++);
      allBreakingNewsList.addAll(breakingNews);
      allBreakingNewsApiResponse.value = ApiResponse.completed(breakingNews);
    } catch (e) {
      allBreakingNewsApiResponse.value = ApiResponse.error(e.toString());
      throw Exception(e.toString());
    }
  }
  Future<void> loadMoreAllBreakingNews() async {
    try {
      //isLoading.value = true;
      final allBreakingNews = await BreakingNewsRepository().getBreakingNews(++page.value);
      if (allBreakingNews.length < 15) {
        hasMoreAllBreakingNews.value = false;
      }
      allBreakingNewsList.addAll(allBreakingNews);

      //isLoading.value = false;
    } catch (e) {
      //isLoading.value = false;
      throw Exception(e.toString());
    }
  }

}