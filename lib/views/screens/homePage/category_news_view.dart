import 'package:english_news_app/data/api_response/api_response.dart';
import 'package:english_news_app/resources/assets/app_image_name.dart';
import 'package:english_news_app/viewmodel/adMob_view_model.dart';
import 'package:english_news_app/viewmodel/home_page/category_news_view_model.dart';
import 'package:english_news_app/views/screens/homePage/news_details_view.dart';
import 'package:english_news_app/views/widgets/error_widgets/error_widgets.dart';
import 'package:english_news_app/views/widgets/loading_effect.dart';
import 'package:english_news_app/views/widgets/news_list_widgets.dart';
import 'package:english_news_app/views/widgets/no_more_news_warning_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CategoryNewsView extends StatefulWidget {
  final String category;
  const CategoryNewsView({super.key,required this.category});

  @override
  State<CategoryNewsView> createState() => _CategoryNewsViewState();
}

class _CategoryNewsViewState extends State<CategoryNewsView> {
  final categoryController = Get.put(CategoryNewsViewModel());
  final adMobController = Get.put(AdMobViewModel());

  @override
  void initState() {
    categoryController.getCategoryNews(widget.category.toLowerCase());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Obx(() {
        final response = categoryController.categoryNewsApiResponse.value;

        if(response.status == Status.isLOADING){
          return LoadingEffectWidgets().loadingEffectWidgets(context);
        }
        else if(response.status == Status.isCOMPLETED){

          return Container(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              itemCount: categoryController.categoryNewsList.length + 1,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index < categoryController.categoryNewsList.length) {
                  final categoryNews = categoryController.categoryNewsList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => const NewsDetailsView(), arguments: [categoryNews]);
                    },
                    child: NewsListWidgets(
                      height: height,
                      width: width,
                      image: categoryNews.urlToImage == null ? AppImageName.altImage : categoryNews.urlToImage.toString(),
                      title: categoryNews.title.toString(),
                      publishedAt: categoryNews.publishedAt.toString().split(' ')[0],
                      source: categoryNews.source!.name.toString(),
                    ),
                  );
                }
                else {
                  return Obx(() {
                    final hasMoreNews = categoryController.hasMoreNews.value;
                    if (hasMoreNews) {
                      return buildLoadMoreButton();
                    } else {
                      return const NoMoreNewsWarningWidgets();
                    }
                  });

                }
              },
              separatorBuilder: (context, index) {

                /// Show add according to this index
                if (index == 2) {
                  return buildBanner(adMobController.bannerAd6);
                } else if(index == 5){
                  return buildBanner(adMobController.bannerAd7);
                }
                else if(index ==10)
                {
                  return buildBanner(adMobController.bannerAd8);
                }
                else if(index == 15)
                {
                  return buildBanner(adMobController.bannerAd9);
                }
                else if(index == 20)
                {
                  return buildBanner(adMobController.bannerAd10);
                }
                else {
                  return const SizedBox();
                }
              },
            )
          );
        }
        else{
          return ErrorWidgets(
            widgetHeight: height*0.5,
            onPressed: (){
              Get.showSnackbar(const GetSnackBar(
                title: "Refreshing....",
                message: "Refreshing news",
                duration: Duration(seconds: 2),
              )
              );
            categoryController.getCategoryNews(widget.category.toLowerCase());
          },
          );
        }
      }),
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: MaterialButton(
        onPressed: ()async{
          categoryController.isLoading.value = true;
          await categoryController.loadMoreCategoryNews(widget.category.toLowerCase());
          await Future.delayed(const Duration(seconds: 2));
          categoryController.isLoading.value = false;
        },
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 48,
          child: categoryController.isLoading.value?
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
}
