import 'package:english_news_app/data/api_response/api_response.dart';
import 'package:english_news_app/resources/assets/app_image_name.dart';
import 'package:english_news_app/viewmodel/adMob_view_model.dart';
import 'package:english_news_app/viewmodel/home_page/allBreaking_news_view_model.dart';
import 'package:english_news_app/views/screens/homePage/news_details_view.dart';
import 'package:english_news_app/views/widgets/button/load_more_news_button_widgets.dart';
import 'package:english_news_app/views/widgets/error_widgets/error_widgets.dart';
import 'package:english_news_app/views/widgets/loading_effect.dart';
import 'package:english_news_app/views/widgets/news_list_widgets.dart';
import 'package:english_news_app/views/widgets/no_more_news_warning_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AllBreakingNewsView extends StatefulWidget {
  const AllBreakingNewsView({super.key});

  @override
  State<AllBreakingNewsView> createState() => _AllBreakingNewsViewState();
}

class _AllBreakingNewsViewState extends State<AllBreakingNewsView> {

  final allBreakingNewsController = Get.put(AllBreakingNewsViewModel());
  final adMobController = Get.put(AdMobViewModel());

  @override
  void initState() {
    allBreakingNewsController.getAllBreakingNews();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Breaking News"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),

      body: Obx(() {
        final response = allBreakingNewsController.allBreakingNewsApiResponse.value;

        if(response.status == Status.isLOADING){
          return LoadingEffectWidgets().loadingEffectWidgets(context);
        }
        else if(response.status == Status.isCOMPLETED){

          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                itemCount: allBreakingNewsController.allBreakingNewsList.length + 1,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index < allBreakingNewsController.allBreakingNewsList.length) {
                    final allBreakingNews = allBreakingNewsController.allBreakingNewsList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => const NewsDetailsView(), arguments: [allBreakingNews]);
                      },
                      child: NewsListWidgets(
                        height: height,
                        width: width,
                        image: allBreakingNews.urlToImage.toString() == 'null' ? AppImageName.altImage : allBreakingNews.urlToImage.toString(),
                        title: allBreakingNews.title.toString(),
                        publishedAt: allBreakingNews.publishedAt.toString().split(' ')[0],
                        source: allBreakingNews.source!.name.toString(),
                      ),
                    );
                  }
                  else {
                    return Obx(() {
                      final hasMoreNews = allBreakingNewsController.hasMoreAllBreakingNews.value;
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
                    return buildBanner(adMobController.bannerAd11);
                  } else if(index == 5){
                    return buildBanner(adMobController.bannerAd12);
                  }
                  else if(index ==8)
                  {
                    return buildBanner(adMobController.bannerAd13);
                  }
                  else if(index == 10)
                  {
                    return buildBanner(adMobController.bannerAd14);
                  }
                  else if (index == 20)
                  {
                    return buildBanner(adMobController.bannerAd15);
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
              allBreakingNewsController.loadMoreAllBreakingNews();
            },
          );
        }
      }
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: MaterialButton(
        onPressed: ()async{
          allBreakingNewsController.isLoading.value = true;
          await allBreakingNewsController.loadMoreAllBreakingNews();
          await Future.delayed(const Duration(seconds: 2));
          allBreakingNewsController.isLoading.value = false;
        },
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 48,
          child: allBreakingNewsController.isLoading.value?
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
