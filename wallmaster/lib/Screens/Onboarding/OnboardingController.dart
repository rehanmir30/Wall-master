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
    OnBoardingModel(imageAsset: 'assets/images/img_2.png', name: ' ',slogon:' ' ),
    OnBoardingModel(imageAsset: 'assets/images/img_1.png', name: ' ',slogon:' ' ),

  ];
}
