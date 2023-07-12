import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallmaster/Controllers/CommonController.dart';

class AdMobService{
  static String? get bannerAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-3874043468724625/1911762444';
    }else if(Platform.isIOS){
      return 'ca-app-pub-3874043468724625/1911762444';
    }
    return null;
  }


  static String? get interstitialAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-3874043468724625/9311223390';
    }else if(Platform.isIOS){
      return'ca-app-pub-3874043468724625/9311223390';
    }
    return null;
  }


  static String? get rewardedAdUniId {
    if(Platform.isAndroid){
      return 'ca-app-pub-3874043468724625/3248894847';
    }else if(Platform.isIOS){
      return 'ca-app-pub-3874043468724625/3248894847';
    }
    return null;
  }

  static String? get nativeAdUniId {
    if(Platform.isAndroid){
      return 'ca-app-pub-3874043468724625/2372821085';
    }else if(Platform.isIOS){
      return 'ca-app-pub-3874043468724625/2372821085';
    }
    return null;
  }


  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad)=> debugPrint('Ad loaded'),
    onAdFailedToLoad: (ad,error) async {
      CommonController commonController = Get.find<CommonController>();
      ad.dispose();
      debugPrint('Ad Failed to load: $error');
      // commonController.createBannerAd();
    },
    onAdOpened: (ad)=>debugPrint('Ad opened'),
    onAdClosed: (ad)=>debugPrint('Ad closed'),
  );

  static final NativeAdListener nativeAdListener = NativeAdListener(
    onAdLoaded: (ad){
      debugPrint('Native Ad loaded');
      },
    onAdFailedToLoad: (ad,error) async {
      ad.dispose();
      debugPrint('Native Ad Failed to load: ${error.message}, ${error.code}');
      // commonController.createBannerAd();
    },
    onAdOpened: (ad)=>debugPrint('Ad opened'),
    onAdClosed: (ad)=>debugPrint('Ad closed'),
  );

  static final BannerAdListener ListbannerAdListener = BannerAdListener(
    onAdLoaded: (ad)=> debugPrint('Ad loaded'),
    onAdFailedToLoad: (ad,error) async {
      CommonController commonController = Get.find<CommonController>();
      ad.dispose();
      debugPrint('Ad Failed to load: $error');
      // await commonController.createListBannerAd();


    },
    onAdOpened: (ad)=>debugPrint('Ad opened'),
    onAdClosed: (ad)=>debugPrint('Ad closed'),
  );


}