import 'package:cached_network_image/cached_network_image.dart';
import 'package:english_news_app/resources/assets/app_image_name.dart';
import 'package:english_news_app/views/widgets/loading_effect.dart';
import 'package:flutter/material.dart';

class NewsListWidgets extends StatelessWidget {
  const NewsListWidgets({
    super.key,
    required this.height,
    required this.width,
    this.image,
    this.title,
    this.publishedAt,
    this.source,
    this.newsBackgroundColor,
  });

  final double height;
  final double width;
  final String? image;
  final String? title;
  final String? publishedAt;
  final String? source;
  final Color? newsBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: newsBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: height * 0.15,
        width: width,

        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 5),

        child: Row(
          children: [
            ///---------> Image --------------->
            buildNewsImage(),
            const SizedBox(width: 5,),

            ///---------> Details --------------->
            Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// News Title
                      Text(title == 'null'? 'No Title Found':"$title",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(),
                      /// News published date and Source name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildNewsPublishDate(),
                          buildNewsSourceName(),
                        ],
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNewsSourceName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      height: 25,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey
      ),
      child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(source == 'null'? 'Unknown':"$source"))
    );
  }

  Widget buildNewsPublishDate() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey
        ),
        child: Text(publishedAt == 'null'? 'Unknown':"$publishedAt")
    );
  }

  Widget buildNewsImage() {
    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.all(2.5),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey,width: 1)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: '$image',
            progressIndicatorBuilder: (context, url, downloadProgress) => LoadingEffectWidgets().imageLoadingEffectWidgets(context),
            errorWidget: (context, url, error) => Image.asset(AppImageName.noImage), fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}