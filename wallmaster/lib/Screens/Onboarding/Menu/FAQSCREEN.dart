import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants/AppColors.dart';
import '../../HomeScreen/SubScreens/Drawer/TermsAndCondtions/TermsAndCondtions.dart';

class FAQSCREEN extends StatefulWidget {
  const FAQSCREEN({super.key});

  @override
  State<FAQSCREEN> createState() => _FAQSCREENState();
}

class _FAQSCREENState extends State<FAQSCREEN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        title:  Text('FAQ'.tr!),
        centerTitle: true,
        backgroundColor: AppColors.black,
      ),
      body: SingleChildScrollView(
          child:Column(
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'PremiumWallpaper'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'PremiumWallpaperDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'PremiumUser'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'PremiumUserDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'PremiumPlan'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'PremiumPlanDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'WallPaperUse'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'WallPaperUseDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'HowtoDownloadWalllaper'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'HowtoDownloadWalllaperDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'PremiumWallpaperRemains'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'PremiumWallpaperRemainsDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'PremiumSeeingAd'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'PremiumSeeingAdDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'CannotWatchWallpaperAfterAd'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'CannotWatchWallpaperAfterAdDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'CanShareWallpapers'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'CanShareWallpapersDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'HowToShareWallpaper'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'HowToShareWallpaperDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 10,height: 10,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),).marginOnly(top: 3),
                  SizedBox(width: 5,),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'DownloadLimits'.tr,
                        style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'DownloadLimitsDescription'.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(()=>TermsAndCondtions());
                                // launch('https://example.com/terms'); // Replace with your terms and conditions URL
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),



            ],).marginSymmetric(horizontal: 10)
      ),
    );

  }
}
