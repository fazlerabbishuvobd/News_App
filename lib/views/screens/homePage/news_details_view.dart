import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_news_app/model/db_model/favourite_new_model.dart';
import 'package:english_news_app/model/news_model.dart';
import 'package:english_news_app/resources/assets/app_image_name.dart';
import 'package:english_news_app/resources/constant/app_constant.dart';
import 'package:english_news_app/viewmodel/adMob_view_model.dart';
import 'package:english_news_app/viewmodel/bookmark_page/bookmark_page_view_model.dart';
import 'package:english_news_app/views/screens/homePage/open_news_url_view.dart';
import 'package:english_news_app/views/widgets/button/custom_icon_button.dart';
import 'package:english_news_app/views/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NewsDetailsView extends StatefulWidget {
  const NewsDetailsView({super.key, this.sourceName, this.date});
  final String? sourceName, date;

  @override
  State<NewsDetailsView> createState() => _NewsDetailsViewState();
}

class _NewsDetailsViewState extends State<NewsDetailsView> {
  final adMobController = Get.put(AdMobViewModel());
  final bookMarkNewsController = Get.put(BookMarkPageViewModel());

  Article news = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          //<--------------- Top Part ---------------------->
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  buildNewsImage(
                      height: height,
                      width: width,
                      image: news.urlToImage == null
                          ? AppImageName.altImage
                          : '${news.urlToImage}'),
                  Positioned(
                    child: buildNewsTitlePart(height, width),
                  ),
                ],
              )),

          //<--------------- Bottom Part ---------------------->
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: height,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue.withOpacity(0.2)),
              child: SingleChildScrollView(
                child: buildNewsDetailsBody(height),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        height: 50,
        width: width * 0.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.amber),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: () {
                  Get.to(() => const OpenNewsUrlView(),
                      arguments: [news.url, news.source!.name]);
                },
                child: const Icon(Icons.link_sharp)),
            const Icon(Icons.comment_rounded),
            GestureDetector(
                onTap: () {
                  debugPrint("Share Button");
                },
                child: const Icon(Icons.share)),
          ],
        ),
      ),
    );
  }

  Widget buildNewsTitlePart(double height, double width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.06,
        ),

        //<--------------------- Back & Bookmark Button ---------------->
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                  color: Colors.transparent.withOpacity(0.4),
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Get.back();
                  }),
              CustomIconButton(
                  color: Colors.transparent.withOpacity(0.4),
                  icon: Icons.bookmark_add_rounded,
                  onPressed: () {
                    bool existsNews(String? title) {
                      /// Checking the News already BookMarked or Not
                      return bookMarkNewsController.bookmarkNewsList.any((news) {
                        return news.newsTitle.toString() == title;
                      });
                    }

                    bool isExists = existsNews(news.title);

                    if (isExists) {
                      toastMessageWidgets('Already Added to Bookmark');
                    } else {
                      final bookmarkNewsDetails = FavouriteNewsModel(
                        newsPicture: news.urlToImage ?? '',
                        newsTitle: news.title ?? '',
                        newsDetails: news.content ?? '',
                        newsSourceName: news.source?.name ?? '',
                        newsUrl: news.url ?? '',
                      );
                      bookMarkNewsController.bookmarkNews(bookmarkNewsDetails).then((value) async{
                        await toastMessageWidgets('Added to Bookmark');
                      });
                    }
                  }),
            ],
          ),
        ),
        const Spacer(),

        /// Title
        Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.transparent.withOpacity(0.5),
            ),
            child: Text(
              news.title.toString(),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )),

        /// Source and PublishedAt
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.amber,
                  ),
                  height: height * 0.04,
                  child: Text(
                    news.source?.name ?? "Unknown",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
              Text(
                (news.publishedAt != null)
                    ? news.publishedAt.toString().split('.0')[0]
                    : 'Unknown',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
        )
      ],
    );
  }


  Widget buildNewsImage({required double height, required double width, required String image}) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
            ),
          ),
          errorWidget: (context, url, error) =>
              Image.asset(AppImageName.noImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget buildNewsDetailsBody(double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Banner - 1
        buildBannerAd(adMobController.bannerAdLarge1),
        SizedBox(
          height: height * 0.01,
        ),

        /// News details
        Text(
          '${news.content.toString()}\n${AppConstant.news}',
          textAlign: TextAlign.justify,
        ),

        /// News Url
        GestureDetector(
          onTap: () {
            Get.to(() => const OpenNewsUrlView(),
                arguments: [news.url, news.source!.name]);
          },
          child: Text(
            'URL: ${news.url.toString()}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),

        SizedBox(
          height: height * 0.04,
        ),

        ///Banner Ad 2
        buildBannerAd(adMobController.bannerAdLarge2),

        SizedBox(
          height: height * 0.12,
        ),
      ],
    );
  }

  Widget buildBannerAd(BannerAd? bannerAds) {
    return Center(
        child: bannerAds != null ? SizedBox(
                width: bannerAds.size.width.toDouble(),
                height: bannerAds.size.height.toDouble(),
                child: AdWidget(ad: bannerAds),
              )
            : const Center(child: Text('Unable to load ad'))
    );
  }
}
