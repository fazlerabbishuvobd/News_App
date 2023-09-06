import 'package:english_news_app/data/api_response/api_response.dart';
import 'package:english_news_app/data/repositories/search_page/search_news_repository.dart';
import 'package:english_news_app/model/news_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchNewsViewModel extends GetxController {

  @override
  void onInit() {
    getSearchNews('country');
    super.onInit();
  }
  final textController = TextEditingController().obs;
  RxBool isVisibleList = false.obs;
  RxString searchKeyword = 'health'.obs;

  RxInt page = 1.obs;

  final searchNewsApiResponse = ApiResponse<List<Article>>.loading().obs;
  final searchNewsList = <Article>[].obs;

  RxBool hasMoreSearchNews = true.obs;
  RxBool isLoading = false.obs;

  Future<void> getSearchNews(String keyword) async {
    searchNewsList.clear();
    try {
      searchNewsApiResponse.value = ApiResponse.loading();
      final searchNews = await SearchNewsRepository().getSearchNews(keyword, page.value++);
      searchNewsList.addAll(searchNews);
      searchNewsApiResponse.value = ApiResponse.completed(searchNews);
    } catch (e) {
      searchNewsApiResponse.value = ApiResponse.error(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> loadMoreSearchNews(String keyword) async {
    try {
      //isLoading.value = true;
      final searchNews = await SearchNewsRepository().getSearchNews(keyword, ++page.value);
      if (searchNews.length < 15) {
        hasMoreSearchNews.value = false;
        searchNewsList.addAll(searchNews);
      } else {
        searchNewsList.addAll(searchNews);
      }
      searchNewsApiResponse.value = ApiResponse.completed(searchNews);
      //isLoading.value = false;
    } catch (e) {
      //isLoading.value = false;
      searchNewsApiResponse.value = ApiResponse.error(e.toString());
      throw Exception(e.toString());
    }
  }
}
