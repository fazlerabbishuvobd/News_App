import 'package:carousel_slider/carousel_controller.dart';
import 'package:english_news_app/data/api_response/api_response.dart';
import 'package:english_news_app/data/repositories/home_page/breaking_news_repository.dart';
import 'package:english_news_app/data/repositories/home_page/top_news_repository.dart';
import 'package:english_news_app/model/news_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePageViewModel extends GetxController {

  @override
  void onInit() {
    getBreakingNews();
    getTopNews();
    super.onInit();
  }

  RxList<bool> isSelectedCategory = List.generate(7, (index) => false).obs;


  ///<---------- Breaking News Slider -------------->
  var sliderCurrentIndex = 0.obs;
  final carouselController = CarouselController().obs;

  void onIndicatorTap(int index) {
    carouselController.value.animateToPage(index,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  void changeIndex(int index) {
    sliderCurrentIndex.value = index;
  }

  ///<----------- API Calling ----------------------->
  RxInt page = 1.obs;
  RxInt breakingNewsPage = 1.obs;
  final breakingNewsApiResponse = ApiResponse<List<Article>>.loading().obs;
  final topNewsApiResponse = ApiResponse<List<Article>>.loading().obs;

  RxBool hasMoreTopNews = true.obs;
  RxBool buttonLoading = false.obs;

  final breakingNewsList = <Article>[].obs;
  final topNewsList = <Article>[].obs;


  Future<void> getBreakingNews() async {
    try {
      breakingNewsApiResponse.value = ApiResponse.loading();
      final breakingNews = await BreakingNewsRepository().getBreakingNews(breakingNewsPage.value++);
      breakingNewsList.addAll(breakingNews);
      breakingNewsApiResponse.value = ApiResponse.completed(breakingNews);
    } catch (e) {
      breakingNewsApiResponse.value = ApiResponse.error(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> getTopNews() async {
    try {
      topNewsApiResponse.value = ApiResponse.loading();
      final topNews = await TopNewsRepository().getTopNews(page.value++);
      topNewsList.addAll(topNews);
      topNewsApiResponse.value = ApiResponse.completed(topNews);
    } catch (e) {
      topNewsApiResponse.value = ApiResponse.error(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> loadMoreTopNews() async {

    try {
      final moreTopNews = await TopNewsRepository().getTopNews(++page.value);
      if (moreTopNews.length < 15) {
        hasMoreTopNews.value = false;
      }
      topNewsList.addAll(moreTopNews);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
