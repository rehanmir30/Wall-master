import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class AdScreen extends StatefulWidget {
  const AdScreen({super.key});

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {

  BannerAd? _bannerAd;


Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BannerAd(
      adUnitId: '',
      request: AdRequest(), 
      size: AdSize.mediumRectangle,
      listener:BannerAdListener(

        onAdLoaded: (ad){
          _bannerAd = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, error){
          print("Failed to load ad ${error.message}");
          ad.dispose();

        },

      ) 
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}