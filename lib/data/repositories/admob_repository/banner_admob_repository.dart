import 'package:english_news_app/services/admob_services/admob_services.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobRepository {
  static BannerAd bannerAdMob(BannerAd? bannerAdNo) {
    return BannerAd(
      adUnitId: AdMobServices.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAdNo = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, err) {
          if(kDebugMode)
          {
            print('Failed to load a banner ad: ${err.message}');
          }
          ad.dispose();
        },
      ),
    );
  }

  static BannerAd bannerAdMobLarge(BannerAd? bannerAdNo) {
    return BannerAd(
      adUnitId: AdMobServices.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAdNo = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, err) {
          if(kDebugMode)
          {
            print('Failed to load a banner ad: ${err.message}');
          }
          ad.dispose();
        },
      ),
    );
  }
}