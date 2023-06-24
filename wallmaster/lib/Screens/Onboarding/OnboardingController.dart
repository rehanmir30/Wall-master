import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../Model/onBoardingModel.dart';

class OnBoardingController extends GetxController {
  var onPageIndex = 0.obs;

  bool get isLastPage => onPageIndex.value == onBoardingPages.length - 1;
  var pageController = PageController();

  forward() {
    if (isLastPage) {
      //go to Dashboard

    } else {
      pageController.nextPage(
          duration: 300.milliseconds, curve: Curves.bounceOut);
    }
  }

  List<OnBoardingModel> onBoardingPages = [
    OnBoardingModel(imageAsset: 'assets/images/img_1.png', name: 'Unlimited wallpapers',slogon:'Download the wallpaper that fits you best.' ),
    OnBoardingModel(imageAsset: 'assets/images/img_1.png', name: 'Download Free wallpapers',slogon:'Always have something to watch\noffline.' ),

  ];
}
