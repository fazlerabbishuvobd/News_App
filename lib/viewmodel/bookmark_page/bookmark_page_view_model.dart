import 'package:english_news_app/data/repositories/db_repository/db_repository.dart';
import 'package:english_news_app/model/db_model/favourite_new_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BookMarkPageViewModel extends GetxController{
  final bookmarkNewsList = <FavouriteNewsModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getAllBookmarkNews();
    super.onInit();
  }

  void getAllBookmarkNews() async{
    try{
      isLoading.value = true;
      bookmarkNewsList.value = await DatabaseRepository.getAllBookmarkNews().timeout(const Duration(seconds: 5));
      isLoading.value = false;
    }catch(e)
    {
      throw Exception(e.toString());
    }
  }

  Future<void> bookmarkNews(FavouriteNewsModel favouriteNews)async{
    await DatabaseRepository.bookmarkNews(favouriteNews);
    getAllBookmarkNews();
  }

  Future<void> removeBookmarkNews(FavouriteNewsModel favouriteNews)async{
    await DatabaseRepository.removeBookmarkNews(favouriteNews);
    getAllBookmarkNews();
  }

}