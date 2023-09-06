import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:english_news_app/data/api_response/api_response.dart';
import 'package:english_news_app/data/repositories/admob_repository/banner_admob_repository.dart';
import 'package:english_news_app/model/news_model.dart';
import 'package:english_news_app/resources/assets/app_image_name.dart';
import 'package:english_news_app/resources/constant/app_constant.dart';
import 'package:english_news_app/services/admob_services/admob_services.dart';
import 'package:english_news_app/viewmodel/adMob_view_model.dart';
import 'package:english_news_app/viewmodel/home_page/home_page_view_model.dart';
import 'package:english_news_app/viewmodel/theme_view_model.dart';
import 'package:english_news_app/views/screens/homePage/allBreaking_news_view.dart';
import 'package:english_news_app/views/screens/homePage/category_news_view.dart';
import 'package:english_news_app/views/screens/homePage/news_details_view.dart';
import 'package:english_news_app/views/screens/homePage/notification_page_view.dart';
import 'package:english_news_app/views/widgets/button/custom_material_button.dart';
import 'package:english_news_app/views/widgets/button/load_more_news_button_widgets.dart';
import 'package:english_news_app/views/widgets/error_widgets/error_widgets.dart';
import 'package:english_news_app/views/widgets/loading_effect.dart';
import 'package:english_news_app/views/widgets/news_list_widgets.dart';
import 'package:english_news_app/views/widgets/no_more_news_warning_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {


  List<String> sliderIndicator = List.generate(10, (index) => '$index');

  final homeController = Get.put(HomePageViewModel());
  final adMobController = Get.put(AdMobViewModel());
  final themeController = Get.put(ThemeViewModel());

  bool isLight = true;
  
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
        title: const Text('Home Page'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isLight = !isLight;
                });
                if (themeController.themeMode.value == ThemeMode.light) {
                  themeController.changeTheme(ThemeMode.dark);
                } else {
                  themeController.changeTheme(ThemeMode.light);
                }
              }, icon: Icon(isLight?Icons.dark_mode:Icons.light_mode)),
          IconButton(
              onPressed: () {
                Get.to(() => const NotificationPageView());
              }, icon: const Icon(Icons.notifications))
        ],
        backgroundColor: Colors.amber,
      ),

      body: RefreshIndicator(
        onRefresh: refresh,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Breaking News Part
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Breaking News",style: TextStyle(fontWeight: FontWeight.bold),),
                            GestureDetector(
                                onTap: (){
                                  Get.to(()=> const AllBreakingNewsView());
                                },
                                child: const Text("view all",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 0.01,),

                      ///------------------ Breaking News Slider --------------->

                      Obx(() {
                        final response = homeController.breakingNewsApiResponse.value;

                        /// Api response checking..
                        if (response.status == Status.isLOADING) {
                          return LoadingEffectWidgets().breakingNewsLoadingEffectWidgets(context);
                        }
                        else if (response.status == Status.isCOMPLETED) {

                          if (homeController.breakingNewsList.isEmpty) {
                            return const Center(child: Text("No Breaking News Found"));
                          }
                          else {
                            return Expanded(
                              child: CarouselSlider.builder(
                                carouselController: homeController.carouselController.value,
                                itemCount: homeController.breakingNewsList.length,
                                itemBuilder: (context, index, realIndex) {
                                  final breakingNews = homeController.breakingNewsList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => const NewsDetailsView(), arguments: [breakingNews]);
                                    },
                                    child: Stack(
                                      children: [
                                        /// Breaking News Image
                                        buildSliderImages(width, breakingNews),

                                        /// Breaking News Title
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          child: buildBreakingNewsTitle(width, breakingNews),
                                        ),

                                        /// Breaking News Source Name
                                        Positioned(
                                            top: 4,
                                            right: 4,
                                            child: buildBreakingNewsSource(breakingNews)
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                options: buildCarouselOptions(context),
                              ),
                            );
                          }
                        }
                        else {
                          return buildBreakingNewsErrorAlert(height);
                        }
                      }),
                    ],
                  )
              ),
              buildSliderIndicators(),

              /// Category Slider Part
              buildCategorySlider(width),
              SizedBox(height: height*0.01,),

              //Top News List Part
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text('Top News',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    SizedBox(height: height*0.01,),

                    //---- Top News List ----->
                    Obx(() {
                      final response = homeController.topNewsApiResponse.value;

                      /// Api response checking
                      if (response.status == Status.isLOADING) {
                        return Container(
                          alignment: Alignment.center,
                          height: height * 0.42,
                          child: LoadingEffectWidgets().loadingEffectWidgets(context),
                        );
                      }
                      else if (response.status == Status.isCOMPLETED) {
                        return SizedBox(
                          height: height * 0.52,
                          width: width,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: homeController.topNewsList.length + 1,
                            itemBuilder: (context, index) {
                              if (index < homeController.topNewsList.length) {
                                final topNews = homeController.topNewsList[index];
                                return GestureDetector(
                                  onTap: (){
                                    Get.to(() => const NewsDetailsView(), arguments: [topNews]);
                                  },
                                  child: SizedBox(
                                    child: NewsListWidgets(
                                      height: height,
                                      width: width,
                                      image: topNews.urlToImage.toString() == 'null' ? AppImageName.altImage : topNews.urlToImage.toString(),
                                      title: topNews.title.toString(),
                                      publishedAt: topNews.publishedAt.toString().split(' ')[0],
                                      source: topNews.source!.name.toString(),

                                    ),
                                  ),
                                );
                              }
                              else {
                                return Obx(() {
                                  final hasMoreTopNews = homeController.hasMoreTopNews.value;

                                  /// More news available then show Load More Button
                                  /// otherwise it shows No data available message
                                  if (hasMoreTopNews) {
                                    return buildLoadMoreButton();
                                  } else {
                                    return const NoMoreNewsWarningWidgets();
                                  }
                                });

                              }
                            }, separatorBuilder: (context, index) {

                              /// Show add according to this index
                              if (index == 2) {
                                return buildBanner(adMobController.bannerAd1);
                              } else if(index == 5){
                                return buildBanner(adMobController.bannerAd2);
                              }
                              else if(index ==10)
                              {
                                return buildBanner(adMobController.bannerAd3);
                              }
                              else if(index == 15)
                              {
                                return buildBanner(adMobController.bannerAd4);
                              }
                              else if (index == 20)
                                {
                                  return buildBanner(adMobController.bannerAd5);
                                }
                              else {
                                return const SizedBox();
                              }
                            },
                          ),
                        );
                      }
                      else {
                        return ErrorWidgets(
                          widgetHeight: height*0.4,onPressed: (){
                            refresh();
                          },
                        );
                      }
                    }),
                  ],
                )
              ),
            ],
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
        ):const Center(child: Text('Advertisement'))
    );
  }

  Widget buildLoadMoreButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MaterialButton(
        onPressed: ()async{
          homeController.buttonLoading.value = true;
          await homeController.loadMoreTopNews();
          await Future.delayed(const Duration(seconds: 2));
          homeController.buttonLoading.value = false;
        },
        color: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 48,
          child: homeController.buttonLoading.value?
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

  Widget buildCategorySlider(double width) {
    return SizedBox(
      height: 45,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber),
              child: const Row(
                children: [
                  Text("Category"),
                  Icon(Icons.category),
                ],
              )
          ),

          SizedBox(
            width: width * 0.72,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Obx(() {
                  return GestureDetector(
                    onTap: () {
                      for (int i = 0; i < homeController.isSelectedCategory.length; i++) {
                        homeController.isSelectedCategory[i] = i == index;
                      }
                      Get.to(() => CategoryNewsView(category: AppConstant.categoryList[index].categoryName));
                    },
                    child: buildCategoryList(index),
                  );
                });
              },
              itemCount: AppConstant.categoryList.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBreakingNewsErrorAlert(double height) {
    return Container(
        alignment: Alignment.center,
        height: height * 0.15,
        child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ops! Something went wrong'),
                Icon(Icons.error_outline,color: Colors.red,)
              ],
            )
        )
    );
  }

  CarouselOptions buildCarouselOptions(BuildContext context) {
    return CarouselOptions(
      height: MediaQuery.sizeOf(context).height * 0.27,
      aspectRatio: 16 / 9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 5),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.3,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index, reason) {
        setState(() {
          homeController.changeIndex(index);
        });
      },
    );
  }

  Widget buildSliderIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: sliderIndicator.map((item) {
        int index = sliderIndicator.indexOf(item);
        return GestureDetector(
          onTap: () {
            homeController.onIndicatorTap(index);
          },
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: homeController.sliderCurrentIndex.value == index
                  ? Colors.amber
                  : Colors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildSliderImages(double width, Article breakingNews) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: breakingNews.urlToImage.toString(),
          progressIndicatorBuilder: (context, url, downloadProgress) => LoadingEffectWidgets().breakingNewsLoadingEffectWidgets(context),
          errorWidget: (context, url, error) => Image.asset(AppImageName.noImage,fit: BoxFit.fill,),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget buildBreakingNewsTitle(double width, Article breakingNews) {
    return FittedBox(
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)),
            color: Colors.black.withOpacity(0.5),
          ),
          height: 80,
          width: width,
          child: Text( breakingNews.title == null ? "No Title Found" : breakingNews.title.toString(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),
          )
      ),
    );
  }

  Widget buildBreakingNewsSource(Article breakingNews) {
    return Container(
      padding: const EdgeInsets.all(5),
      alignment: Alignment.center,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black.withOpacity(0.5),
      ),
      child: Text(breakingNews.source!.name == null ? "Unknown" : breakingNews.source!.name.toString(),
        style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildCategoryList(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(5),
      alignment: Alignment.center,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: homeController.isSelectedCategory[index] ? Colors.grey : Colors.amber.withOpacity(0.5),
      ),
      child: Row(
        children: [
          Text(AppConstant.categoryList[index].categoryName,style: const TextStyle(fontWeight: FontWeight.bold),),
          Image.asset(AppConstant.categoryList[index].categoryImage, fit: BoxFit.fill,)
        ],
      ),
    );
  }

  Future<void> refresh() async {
    Get.showSnackbar(const GetSnackBar(
      title: "Refreshing....",
      message: "Refreshing news",
      duration: Duration(seconds: 2),
    )
    );
    homeController.breakingNewsList.clear();
    await homeController.getBreakingNews();
    homeController.topNewsList.clear();
    await homeController.getTopNews();
  }
}
