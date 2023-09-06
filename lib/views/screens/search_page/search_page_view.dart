import 'package:english_news_app/data/api_response/api_response.dart';
import 'package:english_news_app/resources/assets/app_image_name.dart';
import 'package:english_news_app/viewmodel/adMob_view_model.dart';
import 'package:english_news_app/viewmodel/search_page/search_news_view_model.dart';
import 'package:english_news_app/views/screens/homePage/news_details_view.dart';
import 'package:english_news_app/views/widgets/error_widgets/error_widgets.dart';
import 'package:english_news_app/views/widgets/loading_effect.dart';
import 'package:english_news_app/views/widgets/news_list_widgets.dart';
import 'package:english_news_app/views/widgets/no_more_news_warning_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {

  final searchNewsController = Get.put(SearchNewsViewModel());
  final adMobController = Get.put(AdMobViewModel());

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: height * 0.04),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [

                /// Search Bar part
                Obx(() =>
                  SizedBox(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildSearchBar(width),

                        IconButton(
                          onPressed: () {
                            ///Taking user search keyword (initially search keyword = "health") and calling search news api
                            searchNewsController.searchKeyword.value = searchNewsController.textController.value.text;
                            searchNewsController.getSearchNews(searchNewsController.searchKeyword.value);
                          },
                          icon: const Icon(Icons.send)
                        )
                      ],
                    ),
                  )),

                const SizedBox(height: 10,),

                ///NewsList part
                Obx(() {
                  final response = searchNewsController.searchNewsApiResponse.value;
                  if (response.status == Status.isLOADING) {
                    return LoadingEffectWidgets().loadingEffectWidgets(context);
                  }
                  else if (response.status == Status.isCOMPLETED) {
                    return SizedBox(
                      height: height*0.8,
                      width: width,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: searchNewsController.searchNewsList.length + 1,
                        itemBuilder: (context, index) {
                          if (index < searchNewsController.searchNewsList.length) {
                              final searchNews = searchNewsController.searchNewsList[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => const NewsDetailsView(), arguments: [searchNews]);
                                },
                                child: NewsListWidgets(
                                  height: height,
                                  width: width,
                                  image: searchNews.urlToImage.toString() == 'null' ? AppImageName.altImage : searchNews.urlToImage.toString(),
                                  title: searchNews.title.toString(),
                                  publishedAt: searchNews.publishedAt.toString().split(' ')[0],
                                  source: searchNews.source!.name.toString(),
                                ),
                              );
                          } else {
                            return Obx(() {
                              final hasMoreNews = searchNewsController.hasMoreSearchNews.value;
                              if (hasMoreNews) {
                                return buildLoadMoreButton();
                              } else {
                                return const NoMoreNewsWarningWidgets();
                              }
                            });
                          }
                        }, separatorBuilder: (context, index) {
                        /// Show add according to this index
                        if (index == 2) {
                          return buildBanner(adMobController.bannerAd16);
                        } else if(index == 5){
                          return buildBanner(adMobController.bannerAd17);
                        }
                        else if(index ==10)
                        {
                          return buildBanner(adMobController.bannerAd18);
                        }
                        else if(index == 15)
                        {
                          return buildBanner(adMobController.bannerAd19);
                        }
                        else if(index == 20)
                        {
                          return buildBanner(adMobController.bannerAd20);
                        }
                        else {
                          return const SizedBox();
                        }
                        },
                      ),
                    );
                  } else {
                    return ErrorWidgets(
                      widgetHeight: height * 0.4,
                      onPressed: () {

                      },
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget buildBanner(BannerAd? bannerAds) {
    return Center(
        child: bannerAds != null?
        SizedBox(
          width: bannerAds.size.width.toDouble(),
          height: bannerAds.size.height.toDouble(),
          child: AdWidget(ad: bannerAds),
        ):const Center(child: Text('Unable to load ad'))
    );
  }

  Widget buildLoadMoreButton() {
    return Container(
      margin: const EdgeInsets.only(top: 10,bottom: 40),
      child: MaterialButton(
        onPressed: ()async{
          searchNewsController.isLoading.value = true;
          await searchNewsController.loadMoreSearchNews(searchNewsController.searchKeyword.value);
          searchNewsController.isLoading.value = false;
        },
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 48,
          child: searchNewsController.isLoading.value?
          const Center(child: CircularProgressIndicator()):
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Load More'),
              SizedBox(width: 10,),
              Icon(Icons.cloud_download),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar(double width) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 10),
      width: width*0.8,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black,width: 1)
      ),
      child: TextField(
        controller: searchNewsController.textController.value,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search,color: Colors.amber,),
            hintText: 'Search News',
            suffix: GestureDetector(
                onTap: (){
                  searchNewsController.textController.value.text = '';
                },
                child: const Icon(Icons.clear)),
        ),
      ),
    );
  }
}

