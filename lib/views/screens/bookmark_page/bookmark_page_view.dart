import 'package:english_news_app/model/db_model/favourite_new_model.dart';
import 'package:english_news_app/model/news_model.dart';
import 'package:english_news_app/resources/assets/app_image_name.dart';
import 'package:english_news_app/viewmodel/bookmark_page/bookmark_page_view_model.dart';
import 'package:english_news_app/views/screens/homePage/news_details_view.dart';
import 'package:english_news_app/views/widgets/loading_effect.dart';
import 'package:english_news_app/views/widgets/news_list_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkPageView extends StatefulWidget {
  const BookmarkPageView({super.key});

  @override
  State<BookmarkPageView> createState() => _BookmarkPageViewState();
}

class _BookmarkPageViewState extends State<BookmarkPageView> {

  final bookmarkNewsController = Get.put(BookMarkPageViewModel());

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked News'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Obx(() {
          final news = bookmarkNewsController.bookmarkNewsList;
          if(bookmarkNewsController.isLoading.value == false)
          /// Check Loading State
            {
              /// Check Bookmark List Empty or Not
              if (news.isEmpty) {
                return const Center(
                  child: Text('No bookmarked news found.'),
                );
              }
              else {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: bookmarkNewsController.bookmarkNewsList.length,
                  itemBuilder: (context, index) {
                    final newsList = bookmarkNewsController.bookmarkNewsList[index];

                    /// Converting FavouriteModel to NewsModel for passing data to another screen
                    final result = bookmarkNewsController.bookmarkNewsList.map((element) {
                      return Article(
                          title: element.newsTitle,
                          content: element.newsDetails,
                          url: element.newsUrl,
                          urlToImage: element.newsPicture);
                    }).toList();

                    final bookMarkList = result[index];

                    String source = newsList.newsSourceName ?? 'Unknown';
                    String date = newsList.newsPublishedAt ?? 'Unknown';

                    return GestureDetector(
                    onLongPress: (){
                      buildShowDialog(context, newsList);
                    },
                    onTap: () {
                      Get.to(() => const NewsDetailsView(), arguments: [bookMarkList]);
                    },
                    child: NewsListWidgets(
                      height: height,
                      width: width,
                      image: newsList.newsPicture ?? AppImageName.altImage,
                      title: newsList.newsTitle,
                      source: newsList.newsSourceName,
                      publishedAt: newsList.newsPublishedAt.toString().split('.0')[0],
                    ),
                    );
                  },
                );
              }
            }
          else{
            return LoadingEffectWidgets().loadingEffectWidgets(context);
          }
        }),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context, FavouriteNewsModel newsList) {
    return showDialog(context: context, builder: (context) => AlertDialog(
        title: const Center(child: Text('Do you want to remove?')),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: (){
              Get.back();
            }, child: const Text('No')),
            ElevatedButton(onPressed: (){
              final removeBookmarkNews = FavouriteNewsModel(id: newsList.id);
              bookmarkNewsController.removeBookmarkNews(removeBookmarkNews);
              Get.back();
            }, child: const Text('Yes')
            ),
          ],
        ),
      ),
    );
  }
}
