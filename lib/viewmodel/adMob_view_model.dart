import 'package:english_news_app/data/repositories/admob_repository/banner_admob_repository.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobViewModel extends GetxController{

  BannerAd? bannerAd1,bannerAd2,bannerAd3,bannerAd4,bannerAd5,
      bannerAd6,bannerAd7,bannerAd8,bannerAd9,bannerAd10,
      bannerAd11,bannerAd12,bannerAd13,bannerAd14,bannerAd15,
      bannerAd16,bannerAd17,bannerAd18,bannerAd19,bannerAd20,
      bannerAdLarge1,bannerAdLarge2;

  @override
  void onInit() {
    // homePageViewInitBannerAd();
    // newsDetailPageViewInitAd();
    // breakingNewsPageInitAd();
    // categoryNewsPageInitAd();
    // searchNewsPageInitAd();
    super.onInit();
  }

  void homePageViewInitBannerAd(){
    bannerAd1 = AdMobRepository.bannerAdMob(bannerAd1);
    bannerAd1!.load();
    bannerAd2 = AdMobRepository.bannerAdMob(bannerAd2);
    bannerAd2!.load();
    bannerAd3 = AdMobRepository.bannerAdMob(bannerAd3);
    bannerAd3!.load();
    bannerAd4 = AdMobRepository.bannerAdMob(bannerAd4);
    bannerAd4!.load();
    bannerAd5 = AdMobRepository.bannerAdMob(bannerAd5);
    bannerAd5!.load();
  }

  void newsDetailPageViewInitAd(){
    bannerAdLarge1 = AdMobRepository.bannerAdMobLarge(bannerAdLarge1);
    bannerAdLarge1!.load();
    bannerAdLarge2 = AdMobRepository.bannerAdMobLarge(bannerAdLarge2);
    bannerAdLarge2!.load();
  }

  void categoryNewsPageInitAd(){
    bannerAd6 = AdMobRepository.bannerAdMob(bannerAd6);
    bannerAd6!.load();
    bannerAd7 = AdMobRepository.bannerAdMob(bannerAd7);
    bannerAd7!.load();
    bannerAd8 = AdMobRepository.bannerAdMob(bannerAd8);
    bannerAd8!.load();
    bannerAd9 = AdMobRepository.bannerAdMob(bannerAd9);
    bannerAd9!.load();
    bannerAd10 = AdMobRepository.bannerAdMob(bannerAd10);
    bannerAd10!.load();
  }

  void breakingNewsPageInitAd() {
    bannerAd11 = AdMobRepository.bannerAdMob(bannerAd11);
    bannerAd11!.load();
    bannerAd12 = AdMobRepository.bannerAdMob(bannerAd12);
    bannerAd12!.load();
    bannerAd13 = AdMobRepository.bannerAdMob(bannerAd13);
    bannerAd13!.load();
    bannerAd14 = AdMobRepository.bannerAdMob(bannerAd14);
    bannerAd14!.load();
    bannerAd15 = AdMobRepository.bannerAdMob(bannerAd15);
    bannerAd15!.load();
  }

  void searchNewsPageInitAd(){
    bannerAd16 = AdMobRepository.bannerAdMob(bannerAd16);
    bannerAd16!.load();
    bannerAd17 = AdMobRepository.bannerAdMob(bannerAd17);
    bannerAd17!.load();
    bannerAd18 = AdMobRepository.bannerAdMob(bannerAd18);
    bannerAd18!.load();
    bannerAd19 = AdMobRepository.bannerAdMob(bannerAd19);
    bannerAd19!.load();
    bannerAd20 = AdMobRepository.bannerAdMob(bannerAd20);
    bannerAd20!.load();
  }

}